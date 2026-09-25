-- 编辑缓冲区只保存计划，BufWriteCmd 是唯一的文件操作入口。
local fs = require 'plugins.files.fs'
local state = require 'plugins.files.state'
local planner = require 'plugins.files.planner'
local executor = require 'plugins.files.executor'
local M = {}
local ns = vim.api.nvim_create_namespace 'FilesView'
local wins = {}
local win_options = {
    conceallevel = 3,
    concealcursor = 'nvic',
    wrap = false,
    foldenable = false,
    spell = false,
    list = false,
    signcolumn = 'no',
    foldcolumn = '0',
}

function M.guard(fn)
    return function(...)
        local ok, err = pcall(fn, ...)
        if not ok then vim.notify(tostring(err), vim.log.levels.ERROR, { title = 'Files' }) end
    end
end
function M.current() return assert(state.buffers[vim.api.nvim_get_current_buf()], '当前不是 Files buffer') end
function M.enter()
    local win = vim.api.nvim_get_current_win()
    if not state.buffers[vim.api.nvim_get_current_buf()] then
        M.leave()
        return
    end
    if not wins[win] then
        wins[win] = {}
        for key, value in pairs(win_options) do
            wins[win][key] = vim.wo[win][key]
            vim.wo[win][key] = value
        end
    end
end
function M.leave()
    local win = vim.api.nvim_get_current_win()
    if wins[win] then
        for key, value in pairs(wins[win]) do
            vim.wo[win][key] = value
        end
        wins[win] = nil
    end
end
function M.inherit_window()
    local win = vim.api.nvim_get_current_win()
    local previous = vim.fn.win_getid(vim.fn.winnr '#')
    if state.buffers[vim.api.nvim_get_current_buf()] and wins[previous] then
        wins[win] = vim.deepcopy(wins[previous])
    end
end
function M.forget_window(win) wins[win] = nil end
function M.decorate(buf)
    local s = state.buffers[buf]
    if not s or not s.snapshot then return end
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    local icons = package.loaded['mini.icons']
    for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
        local prefix, id = line:match '^(/(%d+) )'
        local entry = id and s.snapshot.entries[id]
        if entry then
            vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, { end_col = #prefix, conceal = '' })
            if icons then
                local icon, hl = icons.get(entry.type == 'directory' and 'directory' or 'file', entry.name)
                vim.api.nvim_buf_set_extmark(buf, ns, i - 1, #prefix, {
                    virt_text = { { icon .. ' ', hl } },
                    virt_text_pos = 'inline',
                })
            end
        end
    end
end
function M.render(s)
    local snapshot = state.scan(s.root, s.hidden)
    local lines = {}
    for _, entry in ipairs(snapshot.ordered) do
        local name = snapshot.readonly and vim.fn.strtrans(entry.name) or entry.name
        lines[#lines + 1] = '/' .. entry.id .. ' ' .. name .. (entry.type == 'directory' and '/' or '')
    end
    local buf = s.buf
    vim.bo[buf].modifiable = true
    -- 新磁盘快照是新的 undo 边界，不能撤销成上一次事务的文本。
    local levels = vim.bo[buf].undolevels
    vim.bo[buf].undolevels = -1
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].undolevels = levels
    s.snapshot, s.failed = snapshot, false
    vim.bo[buf].modified = false
    vim.bo[buf].readonly = snapshot.readonly or false
    vim.bo[buf].modifiable = not snapshot.readonly
    M.decorate(buf)
    if snapshot.readonly then
        vim.notify('目录包含不支持的名称或特殊文件，整个视图只读。', vim.log.levels.WARN)
    end
end
function M.refresh(s, hidden)
    s = s or M.current()
    if vim.bo[s.buf].modified then
        assert(vim.fn.confirm('放弃尚未提交的目录编辑？', '&Discard\n&Cancel', 2) == 1, '已取消刷新')
    end
    local old = s.hidden
    if hidden ~= nil then s.hidden = hidden end
    local ok, err = pcall(M.render, s)
    if not ok then
        s.hidden = old
        error(err)
    end
end

function M.confirm(lines, title)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = 'wipe'
    local win = vim.api.nvim_open_win(buf, false, {
        relative = 'editor',
        row = 1,
        col = 2,
        width = math.max(1, vim.o.columns - 4),
        height = math.max(1, math.min(#lines, vim.o.lines - 6)),
        style = 'minimal',
        border = 'single',
        title = title,
    })
    vim.cmd 'redraw'
    local ok, choice = pcall(
        vim.fn.confirm,
        table.concat(lines, '\n') .. '\n\n执行以上操作？删除将暂存。',
        '&Apply\n&Cancel',
        2
    )
    if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    if not ok then error(choice) end
    return choice == 1
end
function M.write(buf)
    local s = assert(state.buffers[buf])
    assert(not s.failed, '上次提交失败，请查看日志并使用 gr 重新扫描后再编辑')
    assert(not s.snapshot.readonly, '此目录视图只读')
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local plan = planner.build(lines, s.snapshot)
    if #plan.ops == 0 then
        M.render(s)
        return
    end
    local expected = executor.prepare(plan)
    if not M.confirm(planner.describe(plan), ' Files: operation plan ') then
        error '已取消，目录编辑仍保留'
    end
    assert(vim.deep_equal(lines, vim.api.nvim_buf_get_lines(buf, 0, -1, false)), '确认期间 buffer 发生变化')
    local ok, message = executor.execute(plan, expected)
    if not ok then
        -- 保留失败计划而不是伪装成全部成功；强制用户检查日志、刷新。
        s.failed = true
        vim.bo[buf].modifiable = false
        error(message)
    end
    M.render(s)
    vim.notify(message)
end

function M.select(mode)
    local s = M.current()
    local line = vim.api.nvim_get_current_line()
    local id, name = line:match '^/(%d+) (.*)$'
    local entry = id and s.snapshot.entries[id]
    assert(entry, '请先保存新条目')
    local original = entry.name .. (entry.type == 'directory' and '/' or '')
    assert(s.snapshot.readonly or name == original, '请先保存重命名后的条目')
    local path = fs.join(s.root, entry.name)
    local stat = assert(vim.uv.fs_stat(path), '文件已消失或符号链接失效，请刷新')
    if mode == 'vertical' then vim.cmd 'vsplit' end
    if mode == 'horizontal' then vim.cmd 'split' end
    if stat.type == 'directory' then
        require('plugins.files').open(path)
    else
        assert(stat.type == 'file', '不支持打开此文件类型')
        vim.cmd.edit(vim.fn.fnameescape(path))
    end
end
function M.close()
    local s = M.current()
    assert(
        not vim.bo[s.buf].modified or vim.fn.confirm('保留未提交编辑并离开？', '&Leave\n&Cancel', 2) == 1,
        '已取消'
    )
    if s.previous and vim.api.nvim_buf_is_valid(s.previous) then
        vim.api.nvim_win_set_buf(0, s.previous)
    else
        vim.cmd 'enew'
    end
end
function M.attach(buf, root, previous, group)
    local s = { buf = buf, root = root, previous = previous, hidden = false }
    state.buffers[buf] = s
    vim.bo[buf].buftype = 'acwrite'
    vim.bo[buf].bufhidden = 'hide'
    vim.bo[buf].buflisted = false
    vim.bo[buf].swapfile = false
    vim.bo[buf].undofile = false
    vim.bo[buf].modeline = false
    vim.bo[buf].filetype = 'files'
    for _, name in ipairs {
        'minicompletion_disable',
        'minipairs_disable',
        'minitrailspace_disable',
        'minisnippets_disable',
        'minidiff_disable',
        'miniindentscope_disable',
    } do
        vim.b[buf][name] = true
    end
    vim.api.nvim_clear_autocmds { group = group, event = 'BufWriteCmd', buffer = buf }
    vim.api.nvim_create_autocmd('BufWriteCmd', {
        group = group,
        buffer = buf,
        callback = function() M.write(buf) end,
        desc = 'Commit directory edits after confirmation',
    })
    local mappings = {
        { '<CR>', function() M.select() end, 'Open entry' },
        { '<C-v>', function() M.select 'vertical' end, 'Open entry in vertical split' },
        { '<C-x>', function() M.select 'horizontal' end, 'Open entry in horizontal split' },
        { '-', function() require('plugins.files').open(vim.fs.dirname(M.current().root)) end, 'Parent directory' },
        {
            'g.',
            function()
                local current = M.current()
                M.refresh(current, not current.hidden)
            end,
            'Toggle hidden files',
        },
        { 'gr', function() M.refresh() end, 'Refresh directory' },
        { 'q', M.close, 'Return to previous buffer' },
        { 'g?', function() vim.cmd 'help files-manager' end, 'Files help' },
    }
    for _, map in ipairs(mappings) do
        vim.keymap.set('n', map[1], M.guard(map[2]), { buffer = buf, desc = map[3] })
    end
    M.render(s)
    return s
end
return M
