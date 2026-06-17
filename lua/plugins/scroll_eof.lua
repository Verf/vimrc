local M = {}

local defaults = {
    pattern = '*',
    insert_mode = false,
    floating = true,
    disabled_filetypes = { 'terminal' },
    disabled_modes = { 't', 'nt' },
}

local function disabled()
    if M.opts.disabled_filetypes[vim.bo.filetype] then
        return true
    end
    if M.opts.disabled_modes[vim.api.nvim_get_mode().mode] then
        return true
    end
    if vim.bo.buftype == 'nofile' then
        return true
    end
    return false
end

local function on_move(ev)
    if disabled() then
        return
    end

    if not M.opts.floating then
        local cfg = vim.api.nvim_win_get_config(0)
        if cfg.relative ~= '' then
            return
        end
    end

    if ev.event == 'WinScrolled' then
        local e = vim.v.event[tostring(vim.api.nvim_get_current_win())]
        if e and e.topline <= 0 then
            return
        end
    end

    local win_height = vim.fn.winheight(0)
    local win_cur_line = vim.fn.winline()
    local dist = win_height - win_cur_line

    if dist < M.scrolloff then
        local view = vim.fn.winsaveview()
        vim.fn.winrestview {
            skipcol = 0,
            topline = view.topline + M.scrolloff - dist,
        }
    end
end

local function on_resize()
    if disabled() then
        return
    end

    local win_height = vim.fn.winheight(0)
    local half = math.floor(win_height / 2)

    if M.initial_scrolloff < half then
        if vim.o.scrolloff < M.initial_scrolloff then
            vim.o.scrolloff = M.initial_scrolloff
            M.scrolloff = M.initial_scrolloff
        end
        return
    end

    M.scrolloff = half
    vim.o.scrolloff = (win_height % 2 == 0 and M.scrolloff > 0) and M.scrolloff - 1 or M.scrolloff
end

M.setup = function(opts)
    M.opts = vim.tbl_deep_extend('force', defaults, opts or {})

    -- 转为哈希表以支持 O(1) 查找
    do
        local t = {}
        for _, ft in ipairs(M.opts.disabled_filetypes) do
            t[ft] = true
        end
        M.opts.disabled_filetypes = t
    end
    do
        local t = {}
        for _, m in ipairs(M.opts.disabled_modes) do
            t[m] = true
        end
        M.opts.disabled_modes = t
    end

    M.initial_scrolloff = vim.o.scrolloff
    M.scrolloff = vim.o.scrolloff

    local events = { 'CursorMoved', 'WinScrolled' }
    if M.opts.insert_mode then
        events[#events + 1] = 'CursorMovedI'
    end

    local augroup = vim.api.nvim_create_augroup('scroll_eof', { clear = true })

    vim.api.nvim_create_autocmd(events, {
        group = augroup,
        pattern = M.opts.pattern,
        callback = on_move,
        desc = 'scroll EOF',
    })

    vim.api.nvim_create_autocmd({ 'VimResized', 'BufEnter' }, {
        group = augroup,
        pattern = M.opts.pattern,
        callback = on_resize,
        desc = 'scroll EOF: resize',
    })

    on_resize()
    vim.defer_fn(on_resize, 0)
end

return M
