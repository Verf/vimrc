-- 先处理可回滚的操作；删除从原路径执行，不能由执行器撤销。
local fs = require 'plugins.files.fs'
local planner = require 'plugins.files.planner'
local deletion = require 'plugins.files.deletion'
local uv = vim.uv
local M = {}

local function affected_buffers(plan)
    for buf, directory in pairs(require('plugins.files.state').buffers) do
        if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified then
            for _, op in ipairs(plan.ops) do
                assert(
                    not op.src or op.kind == 'copy' or not fs.inside(directory.root, op.src),
                    '操作涉及未提交的目录 buffer: ' .. directory.root
                )
            end
        end
    end
    local result = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local path = vim.api.nvim_buf_get_name(buf)
        if path ~= '' and vim.bo[buf].buftype == '' then
            for _, op in ipairs(plan.ops) do
                if op.src and fs.inside(path, op.src) then
                    assert(not vim.bo[buf].modified, '操作涉及未保存的 buffer: ' .. path)
                    result[buf] = path
                end
                if op.dst and fs.inside(path, op.dst) then
                    local moving_away = false
                    for _, source in ipairs(plan.ops) do
                        if source.src and source.kind ~= 'copy' and fs.inside(path, source.src) then
                            moving_away = true
                        end
                    end
                    assert(moving_away, '目标已有文件 buffer，请先关闭: ' .. path)
                end
            end
        end
    end
    return result
end

function M.prepare(plan)
    planner.validate(plan)
    affected_buffers(plan)
    local expected = { sources = {} }
    for _, op in ipairs(plan.ops) do
        if op.src and not expected.sources[op.src] then expected.sources[op.src] = fs.tree(op.src) end
        if op.kind == 'delete' and not expected.deletion then expected.deletion = deletion.select() end
    end
    return expected
end

function M.execute(plan, expected)
    planner.validate(plan)
    local buffers = affected_buffers(plan)
    for path, fingerprint in pairs(expected.sources) do
        assert(vim.deep_equal(fs.tree(path), fingerprint), '确认期间源文件发生改变: ' .. path)
    end
    local stage
    local undo, locations, deletes, deferred, deleted = {}, {}, {}, {}, {}
    for _, op in ipairs(plan.ops) do
        if op.kind == 'delete' then deletes[fs.key(op.src)] = true end
    end
    local function place(op, fn)
        -- 若目标与待删除条目同名，必须等原位置腾空。
        if deletes[fs.key(op.dst)] then
            deferred[#deferred + 1] = fn
        else
            fn()
        end
    end
    local function update_buffers(src, dst)
        -- 同时更新已打开文件的名称（包括目录下的文件），避免保存到旧位置。
        for buf, name in pairs(buffers) do
            if fs.inside(name, src) and vim.api.nvim_buf_is_valid(buf) then
                local new = dst .. name:sub(#src + 1)
                buffers[buf] = new
                vim.api.nvim_buf_set_name(buf, new)
            end
        end
    end
    local function move(src, dst)
        fs.rename(src, dst)
        -- 磁盘移动成功后立即登记回滚，再触发 buffer 回调。
        undo[#undo + 1] = function()
            assert(fs.stat(dst), '回滚源已消失: ' .. dst)
            fs.rename(dst, src)
            update_buffers(dst, src)
        end
        update_buffers(src, dst)
    end
    local function mkdir(path)
        local stat = fs.stat(path)
        if stat then
            assert(stat.type == 'directory', '父路径不是目录: ' .. path)
            return
        end
        mkdir(vim.fs.dirname(path))
        fs.must(uv.fs_mkdir(path, 493))
        undo[#undo + 1] = function() fs.must(uv.fs_rmdir(path)) end
    end
    local function delete(op)
        local src = op.src
        assert(vim.deep_equal(fs.tree(src), expected.sources[src]), '删除前源文件已改变: ' .. src)
        -- 执行其他操作时触发的回调仍可能修改 buffer。
        local current = affected_buffers { ops = { op } }
        expected.deletion.remove(src)
        assert(not fs.stat(src), '删除后原路径仍存在: ' .. src)
        deleted[#deleted + 1] = src
        for buf in pairs(current) do
            buffers[buf] = nil
            if vim.api.nvim_buf_is_valid(buf) then
                local removed, remove_err = pcall(vim.api.nvim_buf_delete, buf, { force = false })
                if not removed then
                    vim.notify(
                        '文件已删除，但 buffer 清理失败: ' .. tostring(remove_err),
                        vim.log.levels.WARN
                    )
                end
            end
        end
    end
    local ok, err = pcall(function()
        for _, op in ipairs(plan.ops) do
            if op.kind == 'move' then
                stage = stage or fs.must(uv.fs_mkdtemp(fs.join(plan.root, fs.stage_prefix .. 'XXXXXX')))
                local path = fs.join(stage, vim.fs.basename(op.src))
                move(op.src, path)
                locations[op.src] = path
            end
        end
        -- 显式目录和隐式父目录统一创建，避免输入行序影响执行结果。
        for _, op in ipairs(plan.ops) do
            if op.dst then
                fs.check_parent(plan.root, op.relative)
                mkdir(vim.fs.dirname(op.dst))
                if op.kind == 'create' and op.directory then place(op, function() mkdir(op.dst) end) end
            end
        end
        for _, op in ipairs(plan.ops) do
            if op.kind == 'copy' or (op.kind == 'create' and not op.directory) then
                place(op, function()
                    if op.kind == 'copy' then
                        fs.copy(locations[op.src] or op.src, op.dst)
                    else
                        fs.write(op.dst, '', true)
                    end
                    local fingerprint = fs.tree(op.dst)
                    undo[#undo + 1] = function()
                        assert(vim.deep_equal(fs.tree(op.dst), fingerprint), '回滚目标已改变: ' .. op.dst)
                        fs.remove(op.dst)
                    end
                end)
            end
        end
        for _, op in ipairs(plan.ops) do
            if op.kind == 'move' then place(op, function() move(locations[op.src], op.dst) end) end
        end
        for _, op in ipairs(plan.ops) do
            if op.kind == 'delete' then delete(op) end
        end
        for _, fn in ipairs(deferred) do
            fn()
        end
    end)
    local messages = { ok and '文件操作已完成。' or '提交失败: ' .. tostring(err) }
    if not ok then
        for i = #undo, 1, -1 do
            local restored, rollback_err = pcall(undo[i])
            if not restored then messages[#messages + 1] = '回滚失败: ' .. tostring(rollback_err) end
        end
        if #deleted > 0 then messages[#messages + 1] = '已删除，未回滚:\n' .. table.concat(deleted, '\n') end
    end
    -- 只移除空的中转目录；失败时保留尚未搬回的源文件。
    if stage then
        local removed, cleanup_err = uv.fs_rmdir(stage)
        if not removed then messages[#messages + 1] = ('中转目录未清理: %s\n%s'):format(stage, cleanup_err) end
    end
    return ok, table.concat(messages, '\n')
end
return M
