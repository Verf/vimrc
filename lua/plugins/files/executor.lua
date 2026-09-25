-- 保守执行：先暂存所有移动源以解决环，再创建/复制/移动；每一步写日志。
local fs = require 'plugins.files.fs'
local planner = require 'plugins.files.planner'
local trash = require 'plugins.files.trash'
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
    local sources = {}
    for _, op in ipairs(plan.ops) do
        if op.src and not sources[op.src] then sources[op.src] = fs.tree(op.src) end
    end
    return sources
end

function M.execute(plan, expected)
    planner.validate(plan)
    local buffers = affected_buffers(plan)
    for path, fingerprint in pairs(expected) do
        assert(vim.deep_equal(fs.tree(path), fingerprint), '确认期间源文件发生改变: ' .. path)
    end
    local tx = trash.begin(plan)
    local undo, locations, touched_buffers = {}, {}, {}
    local function step(label, fn)
        tx.data.pending = label
        trash.save(tx)
        fn()
        tx.data.steps[#tx.data.steps + 1] = label
        tx.data.pending = nil
        trash.save(tx)
    end
    local function update_buffers(src, dst)
        -- 同时更新已打开文件的名称（包括目录下的文件），避免保存到旧位置。
        for buf, name in pairs(buffers) do
            if fs.inside(name, src) and vim.api.nvim_buf_is_valid(buf) then
                local new = dst .. name:sub(#src + 1)
                buffers[buf] = new
                touched_buffers[buf] = true
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
        if fs.stat(path) then
            assert(fs.stat(path).type == 'directory', '父路径不是目录: ' .. path)
            return
        end
        mkdir(vim.fs.dirname(path))
        step('MKDIR ' .. path, function()
            fs.must(uv.fs_mkdir(path, 493))
            undo[#undo + 1] = function() fs.must(uv.fs_rmdir(path)) end
        end)
    end
    local ok, err = pcall(function()
        for i, op in ipairs(plan.ops) do
            if op.kind == 'move' or op.kind == 'delete' then
                local slot = 'source-' .. i
                local stage = fs.join(tx.path, slot)
                step('STAGE ' .. op.src .. ' → ' .. stage, function() move(op.src, stage) end)
                locations[op.src] = stage
                if op.kind == 'delete' then
                    tx.data.deleted[#tx.data.deleted + 1] = { slot = slot, name = vim.fs.basename(op.src) }
                    trash.save(tx)
                end
            end
        end
        -- 显式目录和隐式父目录统一创建，避免输入行序影响执行结果。
        for _, op in ipairs(plan.ops) do
            if op.dst then
                fs.check_parent(plan.root, op.relative)
                mkdir(vim.fs.dirname(op.dst))
                if op.kind == 'create' and op.directory then mkdir(op.dst) end
            end
        end
        for _, op in ipairs(plan.ops) do
            if op.kind == 'copy' or (op.kind == 'create' and not op.directory) then
                step(op.kind:upper() .. ' ' .. op.dst, function()
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
            if op.kind == 'move' then
                step('MOVE ' .. op.src .. ' → ' .. op.dst, function() move(locations[op.src], op.dst) end)
            end
        end
        tx.data.status = 'complete'
        trash.save(tx)
    end)
    if not ok then
        tx.data.status, tx.data.error = 'failed', tostring(err)
        tx.data.rollback_errors = {}
        for i = #undo, 1, -1 do
            local restored, rollback_err = pcall(undo[i])
            if not restored then table.insert(tx.data.rollback_errors, tostring(rollback_err)) end
        end
        pcall(trash.save, tx)
        return false,
            ('提交失败: %s\n日志/残留文件: %s\n回滚错误: %s'):format(
                err,
                tx.path,
                table.concat(tx.data.rollback_errors, '\n')
            ),
            tx
    end
    -- 删除的文件 buffer 不能继续保存；只清理未修改的对应 buffer。
    for buf, path in pairs(buffers) do
        if touched_buffers[buf] and fs.inside(path, tx.path) and vim.api.nvim_buf_is_valid(buf) then
            local removed, remove_err = pcall(vim.api.nvim_buf_delete, buf, { force = false })
            if not removed then
                vim.notify('文件已暂存，但 buffer 清理失败: ' .. tostring(remove_err), vim.log.levels.WARN)
            end
        end
    end
    return true, '文件操作已完成。日志: ' .. tx.path, tx
end
return M
