-- fold.lua — Treesitter-based code folding with styled foldtext and foldcolumn icons

local M = {}

-- foldtext 缓存，按 buffer 分组，key 为折叠起始行号
local foldtext_cache = {}

-- 获取一行中每个字符的 treesitter 高亮分段
-- 返回 { {text, hl?}, ... } 或 nil（无 parser 时降级）
local function get_ts_hl_segments(bufnr, lnum)
    local line = vim.fn.getline(lnum)
    if #line == 0 then return { { text = '' } } end
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then return nil end
    local segments = {}
    local last_hl = false
    local seg_start = 0
    for col = 0, #line - 1 do
        local ok2, captures = pcall(vim.treesitter.get_captures_at_pos, bufnr, lnum - 1, col)
        local hl = nil
        if ok2 and #captures > 0 then hl = '@' .. captures[#captures].capture end
        if hl ~= last_hl then
            if col > seg_start then
                local t = line:sub(seg_start + 1, col)
                table.insert(segments, last_hl and last_hl ~= false and { text = t, hl = last_hl } or { text = t })
            end
            seg_start = col
            last_hl = hl
        end
    end
    if seg_start < #line then
        local t = line:sub(seg_start + 1)
        table.insert(segments, last_hl and last_hl ~= false and { text = t, hl = last_hl } or { text = t })
    end
    return segments
end

-- 自定义 foldtext：返回 {{text, hl?}, ...} 元组列表
function M.fold_text()
    local fold_start = vim.v.foldstart
    local fold_end = vim.v.foldend
    if fold_start == 0 then return { { '' } } end
    local fold_lines = fold_end - fold_start + 1
    local bufnr = vim.api.nvim_get_current_buf()
    local tick = vim.api.nvim_buf_get_changedtick(bufnr)

    -- 缓存命中
    local cache = foldtext_cache[bufnr]
    if cache and cache[fold_start] then
        local entry = cache[fold_start]
        if entry.tick == tick and entry.fold_end == fold_end then return entry.text end
    end

    -- 后缀
    local suffix = '󰈉 ' .. fold_lines .. ' lines'

    -- 第一行
    local first_line = vim.fn.getline(fold_start):gsub('%s+$', '')
    local segments = get_ts_hl_segments(bufnr, fold_start)

    -- 构建结果：第一行（treesitter 高亮） + 分隔 + 后缀
    local result = {}

    if segments then
        for _, seg in ipairs(segments) do
            local text = seg.text or ''
            if #text > 0 then
                local item = seg.hl and { text, seg.hl } or { text }
                table.insert(result, item)
            end
        end
    else
        table.insert(result, { first_line })
    end

    -- 两个空格分隔，然后后缀
    table.insert(result, { '  ' })
    table.insert(result, { suffix, 'Comment' })

    -- 写入缓存
    if not foldtext_cache[bufnr] then foldtext_cache[bufnr] = {} end
    foldtext_cache[bufnr][fold_start] = {
        text = result,
        tick = tick,
        fold_end = fold_end,
    }

    return result
end

-- 自定义 foldcolumn 图标：判断每一行应显示折叠/展开/留白图标
function M.fold_icon()
    local lnum = vim.v.lnum
    local fold_closed = vim.fn.foldclosed(lnum)
    local fcs = vim.opt.fillchars:get()

    -- 1. 已闭合的折叠：永远显示合上的图标
    if fold_closed == lnum then return (fcs.foldclose or '') .. ' ' end
    -- 2. 若光标所在行是折叠起点时，显示展开的图标
    if lnum == vim.fn.line '.' then
        local fold_level = vim.fn.foldlevel(lnum)
        local fold_level_before = lnum == 1 and 0 or vim.fn.foldlevel(lnum - 1)
        -- 如果当前行的折叠层级大于上一行，说明这里是代码块/函数的起点
        if fold_level > fold_level_before then return (fcs.foldopen or '') .. ' ' end
    end
    -- 3. 其他所有行留白
    return '  '
end

-- 清除指定 buffer 的 foldtext 缓存
function M.clear_cache(bufnr)
    foldtext_cache[bufnr] = nil
end

function M.setup()
    -- fillchars 折叠相关
    vim.opt.fillchars:append { foldopen = '', foldclose = '', foldsep = ' ', fold = ' ' }

    -- 折叠选项
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.opt.foldtext = 'v:lua._G.custom_fold_text()'
    vim.opt.foldcolumn = '1' -- 在左侧显示折叠层级指示器 (0 为隐藏)
    vim.opt.foldlevel = 99 -- 默认不折叠任何代码
    vim.opt.foldlevelstart = 99 -- 打开文件时默认全展开
    vim.opt.foldenable = true -- 启用折叠
    vim.opt.foldminlines = 2 -- 少于 3 行的区域不创建折叠
    vim.opt.foldnestmax = 4 -- 最大折叠嵌套深度

    -- 导出全局函数供 statuscolumn 和 foldtext 使用
    _G.custom_fold_icon = M.fold_icon
    _G.custom_fold_text = M.fold_text
    vim.opt.statuscolumn = '%s%=%l %#FoldColumn#%{v:lua.custom_fold_icon()}%*'

    -- 缓冲内容变更时清除对应 buffer 的 foldtext 缓存
    vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI', 'TextChangedP' }, {
        group = _G.MyGroup,
        callback = function(args) M.clear_cache(args.buf) end,
    })
end

return M
