-- 原生 buffer 文件管理器，专用 URI 不参与普通文件的自动保存。
local fs = require 'plugins.files.fs'
local state = require 'plugins.files.state'
local view = require 'plugins.files.view'
local trash = require 'plugins.files.trash'
local M = {}
local group

local function uri(root) return (vim.uri_from_fname(root):gsub('^file:', 'files:')) end
local function decode(name) return vim.uri_to_fname((name:gsub('^files:', 'file:'))) end

function M.open(path)
    local previous = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(previous)
    local locate
    if not path or path == '' then
        if state.buffers[previous] then
            path = vim.fs.dirname(state.buffers[previous].root)
        elseif name ~= '' and vim.bo[previous].buftype == '' then
            path, locate = vim.fs.dirname(name), vim.fs.basename(name)
        else
            path = vim.fn.getcwd()
        end
    end
    local root = fs.canonical(path)
    assert(fs.stat(root).type == 'directory', '不是目录: ' .. root)
    local target = uri(root)
    local buf = vim.fn.bufnr(target)
    if buf == -1 then
        buf = vim.api.nvim_create_buf(false, false)
        vim.api.nvim_buf_set_name(buf, target)
    end
    if not vim.api.nvim_buf_is_loaded(buf) then vim.fn.bufload(buf) end
    local s = state.buffers[buf] or view.attach(buf, root, previous, group)
    if previous ~= buf then s.previous = previous end
    vim.api.nvim_win_set_buf(0, buf)
    view.enter()
    if locate then
        for row, entry in ipairs(s.snapshot.ordered) do
            if entry.name == locate then
                vim.api.nvim_win_set_cursor(0, { row, #entry.id + 2 })
                break
            end
        end
    end
    return buf
end

local function takeover(args)
    if state.buffers[args.buf] then return end
    local name = vim.api.nvim_buf_get_name(args.buf)
    if name == '' then return end
    if name:match '^files://' then
        view.attach(args.buf, fs.canonical(decode(name)), nil, group)
        view.enter()
        return
    end
    if vim.bo[args.buf].buftype ~= '' then return end
    local stat = vim.uv.fs_stat(name)
    if not stat or stat.type ~= 'directory' then return end
    local root = fs.canonical(name)
    local existing = vim.fn.bufnr(uri(root))
    if existing ~= -1 and existing ~= args.buf then
        M.open(root)
        if not vim.bo[args.buf].modified then pcall(vim.api.nvim_buf_delete, args.buf, { force = false }) end
    else
        vim.api.nvim_buf_set_name(args.buf, uri(root))
        view.attach(args.buf, root, nil, group)
        view.enter()
    end
end

local function trash_action(clean)
    local s = view.current()
    assert(not vim.bo[s.buf].modified and not s.failed, '请先提交或刷新当前目录编辑')
    local choices = trash.list(s.root)
    assert(#choices > 0, '当前目录没有暂存日志')
    vim.ui.select(
        choices,
        {
            prompt = clean and '永久清理事务（不能撤销）' or '恢复事务中的删除条目',
            format_item = function(tx)
                return ('%s %s %s (%d deleted)'):format(
                    vim.fs.basename(tx.path),
                    tx.data.time,
                    tx.data.status,
                    #tx.data.deleted
                )
            end,
        },
        view.guard(function(tx)
            if not tx then return end
            assert(vim.api.nvim_buf_is_valid(s.buf) and not vim.bo[s.buf].modified, '目录编辑状态已变化')
            assert(
                vim.fn.confirm(
                    (clean and '永久删除暂存内容及日志？\n' or '恢复删除条目？\n') .. tx.path,
                    '&Yes\n&Cancel',
                    2
                ) == 1,
                '已取消'
            )
            if clean then
                trash.clean(tx)
            else
                trash.restore(tx)
            end
            view.render(s)
        end)
    )
end

function M.setup()
    if group then return end
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    group = vim.api.nvim_create_augroup('FilesManager', { clear = true })
    vim.api.nvim_create_user_command('Files', view.guard(function(args) M.open(args.args) end), {
        nargs = '?',
        complete = 'dir',
        desc = 'Open editable directory buffer',
    })
    vim.api.nvim_create_user_command('FilesRestore', view.guard(function() trash_action(false) end), {
        desc = 'Restore staged deletions in current directory',
    })
    vim.api.nvim_create_user_command('FilesClean', view.guard(function() trash_action(true) end), {
        desc = 'Permanently remove a completed transaction and its trash',
    })
    vim.api.nvim_create_autocmd('BufReadCmd', {
        group = group,
        pattern = 'files://*',
        callback = view.guard(takeover),
        desc = 'Restore Files URI buffers without replaying edits',
    })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'VimEnter' }, {
        group = group,
        callback = view.guard(function(args)
            takeover(args)
            view.enter()
        end),
        desc = 'Take over directory buffers',
    })
    vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
        group = group,
        callback = view.enter,
        desc = 'Apply Files window options',
    })
    vim.api.nvim_create_autocmd('WinNew', {
        group = group,
        callback = view.inherit_window,
        desc = 'Preserve original options when splitting Files',
    })
    vim.api.nvim_create_autocmd('WinClosed', {
        group = group,
        callback = function(args) view.forget_window(tonumber(args.match)) end,
        desc = 'Forget closed Files windows',
    })
    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
        group = group,
        callback = function(args) view.decorate(args.buf) end,
        desc = 'Decorate Files entry IDs',
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = group,
        callback = function(args)
            if not state.buffers[args.buf] then return end
            local prefix = vim.api.nvim_get_current_line():match '^/%d+ '
            local pos = vim.api.nvim_win_get_cursor(0)
            if prefix and pos[2] < #prefix then vim.api.nvim_win_set_cursor(0, { pos[1], #prefix }) end
        end,
        desc = 'Keep Files cursor on editable names',
    })
    vim.api.nvim_create_autocmd({ 'BufUnload', 'BufWipeout' }, {
        group = group,
        callback = function(args) state.buffers[args.buf] = nil end,
        desc = 'Forget closed Files buffers',
    })
    vim.keymap.set('n', '-', view.guard(function() M.open() end), { desc = 'Open parent directory (Files)' })
end
return M
