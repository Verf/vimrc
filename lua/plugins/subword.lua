-- subword.lua — camelCase/snake_case subword motion (w/e/b)
-- 替代 nvim-spider，仅实现 w/e/b 三个核心动作

local M = {}

local subword_pat = {
    number = '%d+',
    camelForward = '%u?%l+',
    camelBackward = '%l+%u?',
    upperWord = '%u%u+',
    singleUpper = '%f[%w][%u]+%f[^%w]',
}

local skip_punct = {
    '%f[^%s]%p+%f[%s]',
    '^%p+%f[%s]',
    '%f[^%s]%p+$',
    '^%p+$',
}

--- 返回 line 中 >from 的最近匹配位置（1-indexed byte offset），无匹配返回 nil
local function find_closest(line, patterns, from, end_of_word)
    local best
    for _, pat in pairs(patterns) do
        local pos
        if vim.startswith(pat, '^') then
            if from == 1 then
                local s, e = line:find(pat)
                if s then pos = end_of_word and e or s end
            end
        else
            local search_pat = end_of_word and (pat .. '()') or ('()' .. pat)
            for cap in line:gmatch(search_pat) do
                if type(cap) == 'number' then
                    local p = end_of_word and (cap - 1) or cap
                    if p > from then
                        pos = p
                        break
                    end
                end
            end
        end
        if pos and (not best or pos < best) then best = pos end
    end
    return best
end

function M.motion(key)
    local is_e = key == 'e'
    local backwards = key == 'b'
    local end_of_word = is_e
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local last_row = vim.api.nvim_buf_line_count(0)
    local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ''
    local from = col + 1

    for _ = 1, vim.v.count1 do
        while true do
            local pats = vim.deepcopy(subword_pat)
            if backwards then
                pats.camelForward = nil
            else
                pats.camelBackward = nil
            end
            for _, p in ipairs(skip_punct) do
                table.insert(pats, p)
            end

            local next_pos
            if backwards then
                local rev = line:reverse()
                local rev_from = from ~= 0 and (#line - from + 2) or 0
                next_pos = find_closest(rev, pats, rev_from, not end_of_word)
                if next_pos then next_pos = #line - next_pos + 1 end
            else
                next_pos = find_closest(line, pats, from, end_of_word)
            end

            if next_pos then
                from = next_pos
                break
            end

            from = 0
            row = backwards and row - 1 or row + 1
            if row > last_row or row < 1 then return end
            line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ''
        end
    end

    col = from - 1
    local mode = vim.api.nvim_get_mode().mode
    if mode:sub(1, 2) == 'no' then
        if is_e then col = col + 1 end
        if col > #line then
            vim.cmd.normal { 'v', bang = true }
            col = col - 1
        end
    end

    vim.api.nvim_win_set_cursor(0, { row, col })
end

return M
