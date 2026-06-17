-- quickfix.lua — 增强 quickfix：展开/折叠上下文行
-- 替代 quicker.nvim，仅实现 expand/collapse/toggle

local M = {}

--- 获取当前 quickfix 列表（简化：仅支持 quickfix，不支持 loclist）
local function get_qf() return vim.fn.getqflist { all = 0 } end

local function set_qf(items, title, ctx) vim.fn.setqflist({}, 'r', { items = items, title = title, context = ctx }) end

--- 简化版 quickfixtextfunc
---@param info { start_idx: integer, end_idx: integer, id: integer }
function M.quickfixtextfunc(info)
    local qf = vim.fn.getqflist { id = info.id, all = 0 }
    local items = qf.items
    if not items then return {} end

    -- 文件名最大宽度
    local max_fn = 0
    for _, it in ipairs(items) do
        if it.valid == 1 and it.bufnr > 0 then
            local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(it.bufnr), ':~:.')
            max_fn = math.max(max_fn, vim.api.nvim_strwidth(name))
        end
    end
    if max_fn == 0 then max_fn = 1 end
    max_fn = math.min(max_fn, math.floor(vim.o.columns / 2))

    local ret = {}
    for i = info.start_idx, info.end_idx do
        local it = items[i]
        if it then
            local lnum = it.user_data and it.user_data.lnum or it.lnum or 0
            local fn = ''
            if it.bufnr > 0 then
                local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(it.bufnr), ':~:.')
                local w = vim.api.nvim_strwidth(name)
                if w > max_fn then
                    fn = '…' .. name:sub(-max_fn + 1)
                else
                    fn = name .. string.rep(' ', max_fn - w)
                end
            else
                fn = string.rep(' ', max_fn)
            end
            local ln_s = '     '
            if lnum > 0 then ln_s = string.format('%5d', lnum) end
            ret[#ret + 1] = fn .. ' ' .. ln_s .. ' │ ' .. (it.text or '')
        end
    end
    return ret
end

--- 展开上下文
---@param opts? { before?: integer, after?: integer, add_to_existing?: boolean }
function M.expand(opts)
    opts = opts or {}
    local qf = get_qf()
    if not qf.winid or not vim.api.nvim_win_is_valid(qf.winid) then
        vim.notify('quickfix 窗口未打开', vim.log.levels.WARN)
        return
    end

    local ctx = type(qf.context) == 'table' and qf.context or {}
    local qctx = ctx.quicker or { num_before = 0, num_after = 0 }
    ctx.quicker = qctx

    local num_before = opts.before or 2
    local num_after = opts.after or 2
    if opts.add_to_existing then
        num_before = num_before + qctx.num_before
        num_after = num_after + qctx.num_after
    end
    qctx.num_before = num_before
    qctx.num_after = num_after

    local curpos = vim.api.nvim_win_get_cursor(qf.winid)[1]
    local cur_item = qf.items[curpos]

    -- 为每个条目按 bufnr 分组，找每组的下一项避免上下文重叠
    local next_map = {}
    for i = 1, #qf.items do
        local it = qf.items[i]
        if it.valid == 1 and it.bufnr > 0 then
            -- 找同 buffer 的下一个 valid 条目（不同行）
            for j = i + 1, #qf.items do
                local nj = qf.items[j]
                if nj.valid == 1 and nj.bufnr == it.bufnr and nj.lnum ~= it.lnum then
                    next_map[i] = nj
                    break
                end
            end
        end
    end

    local new_items = {}
    local prev_item
    local newpos

    for i, item in ipairs(qf.items) do
        if item.valid == 0 or item.bufnr == 0 then
            new_items[#new_items + 1] = item
        else
            if not vim.api.nvim_buf_is_loaded(item.bufnr) then vim.fn.bufload(item.bufnr) end

            -- 跳过与前一项完全相同的行
            if prev_item and prev_item.bufnr == item.bufnr and prev_item.lnum == item.lnum then goto continue end

            local low = math.max(0, item.lnum - 1 - num_before)

            -- 与前一项重叠时调整下界
            if prev_item and prev_item.bufnr == item.bufnr then
                if prev_item.lnum + num_after >= low then low = prev_item.lnum + num_after end
            end

            local high = item.lnum + num_after
            local next_it = next_map[i]
            if next_it and next_it.lnum <= high then high = next_it.lnum - 1 end

            local lines = vim.api.nvim_buf_get_lines(item.bufnr, low, high, false)
            for j, line in ipairs(lines) do
                local l = low + j
                if l == item.lnum then
                    item.text = line
                    new_items[#new_items + 1] = item
                else
                    new_items[#new_items + 1] = {
                        bufnr = item.bufnr,
                        lnum = 0,
                        text = line,
                        valid = 0,
                        user_data = { lnum = l },
                    }
                end
            end

            prev_item = item
        end
        ::continue::
    end

    -- 恢复光标
    if cur_item then
        for i, it in ipairs(new_items) do
            if it.bufnr == cur_item.bufnr and it.lnum == cur_item.lnum then
                newpos = i
                break
            end
        end
    end
    newpos = newpos or curpos

    set_qf(new_items, qf.title, ctx)
    if qf.winid and vim.api.nvim_win_is_valid(qf.winid) then
        pcall(vim.api.nvim_win_set_cursor, qf.winid, { newpos, 0 })
    end
end

--- 折叠上下文：仅保留 valid==1 的条目
function M.collapse()
    local qf = get_qf()
    if not qf.winid or not vim.api.nvim_win_is_valid(qf.winid) then return end

    local curpos = vim.api.nvim_win_get_cursor(qf.winid)[1]

    local new_items = {}
    local newpos
    for i, item in ipairs(qf.items) do
        if item.valid == 1 then
            new_items[#new_items + 1] = item
            if i <= curpos then newpos = #new_items end
        end
    end

    local ctx = type(qf.context) == 'table' and qf.context or {}
    if ctx.quicker then ctx.quicker = { num_before = 0, num_after = 0 } end

    set_qf(new_items, qf.title, ctx)
    if vim.api.nvim_win_is_valid(qf.winid) then
        pcall(vim.api.nvim_win_set_cursor, qf.winid, { newpos or curpos, 0 })
    end
end

--- 检查 quickfix 窗口是否打开
function M.is_open()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.fn.getwininfo(win)[1].quickfix == 1 then return true end
    end
    return false
end

--- 开关 quickfix 窗口
function M.toggle()
    if M.is_open() then
        vim.cmd.cclose()
    else
        local n = #vim.fn.getqflist()
        if n == 0 then
            vim.notify('quickfix 列表为空', vim.log.levels.WARN)
            return
        end
        vim.cmd.copen { count = math.min(n + 2, 16) }
    end
end

function M.setup(opts)
    opts = opts or {}
    vim.o.quickfixtextfunc = "v:lua.require'plugins.quickfix'.quickfixtextfunc"

    local group = vim.api.nvim_create_augroup('Quicker', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
        pattern = 'qf',
        group = group,
        callback = function(args)
            vim.bo[args.buf].buflisted = false
            local win = vim.fn.bufwinid(args.buf)
            if win ~= -1 then
                vim.wo[win].number = false
                vim.wo[win].relativenumber = false
                vim.wo[win].wrap = false
                vim.wo[win].signcolumn = 'auto'
            end

            if opts.keys then
                for _, k in ipairs(opts.keys) do
                    vim.keymap.set(k.mode or 'n', k[1], k[2], {
                        buffer = args.buf,
                        desc = k.desc,
                        silent = true,
                    })
                end
            end
        end,
    })
end

return M
