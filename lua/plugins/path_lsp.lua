-- ============================================================
-- path_lsp.lua — 文件系统路径补全 LSP（内嵌）
--
-- 使用 vim.lsp.start 创建函数式 transport（无外部进程），
-- 劫持 textDocument/completion 请求，返回文件系统路径候选项。
-- 兼容 mini.completion 的双阶段补全链。
-- ============================================================

local M = {}

-- ============================================================
-- 配置
-- ============================================================
M.config = {
    -- 路径前缀检测边界字符
    word_boundary = '[%s"\'`%(%)%[%]{}<>%=,;|]',
}

-- ============================================================
-- 判断是否看起来像文件系统路径
-- ============================================================
function M.is_path(word)
    if not word or #word == 0 then return false end
    if word:match '^%.%./' then return true end
    if word:match '^%.%\\' then return true end
    if word:match '^%.%.[/\\]' then return true end
    if word:match '^/' then return true end
    if word:match '^\\' then return true end
    if word:match '^~[/\\]' then return true end
    if word:match '^[a-zA-Z]:' then return true end
    if word:match '[/\\]' then return true end
    return false
end

-- ============================================================
-- 从行文本中提取光标前的路径单词
-- 返回提取的 word，可能为空字符串
-- ============================================================
function M._extract_word_from_line(line, col)
    -- col 是 0-indexed LSP character 位置（字节偏移）
    -- Lua 字符串是 1-indexed，所以 line:sub(1, col) 取到 col 位置
    -- 实际光标处字符是 line:sub(col+1, col+1)
    local start = col
    while start > 0 do
        local char = line:sub(start, start)
        if char:match(M.config.word_boundary) then break end
        start = start - 1
    end
    -- start 现在指向边界字符（或 0），word 从 start+1 到 col
    return line:sub(start + 1, col)
end

-- ============================================================
-- 分割路径为目录部分和补全部分
-- ============================================================
function M._split_path(word)
    -- Windows 盘符特殊处理
    local drive = word:match '^([a-zA-Z]:)'
    if drive and #word == #drive then return drive .. '/', '', '/' end
    if drive then
        local after_drive = word:sub(#drive + 1)
        local sep_char = after_drive:match '^([/\\])' or '/'
        local rest = after_drive:gsub('^[/\\]', '')
        local last_sep = 0
        for i = #rest, 1, -1 do
            local c = rest:sub(i, i)
            if c == '/' or c == '\\' then
                last_sep = i
                sep_char = c
                break
            end
        end
        local dir_part = drive .. '/' .. rest:sub(1, last_sep)
        dir_part = dir_part:gsub('\\', '/')
        if #dir_part > 0 and dir_part:sub(-1) ~= '/' then dir_part = dir_part .. '/' end
        local partial = rest:sub(last_sep + 1)
        return dir_part, partial, sep_char
    end

    local last_sep = 0
    local sep_char = '/'
    for i = #word, 1, -1 do
        local c = word:sub(i, i)
        if c == '/' or c == '\\' then
            last_sep = i
            sep_char = c
            break
        end
    end

    return word:sub(1, last_sep), word:sub(last_sep + 1), sep_char
end

-- ============================================================
-- 确定路径解析的基准目录
-- 优先级: LSP root_dir (.git) → buffer 文件目录 → 全局 cwd
-- ============================================================
function M._resolve_base(bufnr, word)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    if word:match '^/' or word:match '^\\' then return '' end
    local drive = word:match '^([a-zA-Z]:)'
    if drive then return drive .. '/' end

    local bufpath = vim.api.nvim_buf_get_name(bufnr)
    if bufpath ~= '' then
        local git_root = vim.fs.root(bufnr, '.git')
        if git_root then return M._normalize_separators(git_root) end
        return M._normalize_separators(vim.fs.dirname(bufpath))
    end

    return M._normalize_separators(vim.fn.getcwd())
end

-- ============================================================
-- 拼接路径
-- ============================================================
function M._join_path(base, relative)
    if base == '' then return relative end
    if relative:match '^/' or relative:match '^[a-zA-Z]:' then return relative end
    base = M._normalize_separators(base)
    if base:sub(-1) ~= '/' then base = base .. '/' end
    relative = M._normalize_separators(relative)
    -- 去掉 ./
    while relative:match '^%./' do
        relative = relative:sub(3)
    end
    -- 处理 ../
    while relative:match '^%.%./' do
        relative = relative:sub(4)
        base = M._parent_dir(base)
    end
    return base .. relative
end

-- ============================================================
-- 获取父目录路径
-- ============================================================
function M._parent_dir(path)
    path = M._normalize_separators(path):gsub('/$', '')
    if path == '' or path == '/' then return '/' end
    if path:match '^[a-zA-Z]:/$' then return path end
    if path:match '^[a-zA-Z]:$' then return path .. '/' end
    local parent = path:match '^(.*)/'
    if not parent then return path .. '/' end
    return parent .. '/'
end

-- ============================================================
-- 规范化路径分隔符
-- ============================================================
function M._normalize_separators(path) return path:gsub('\\', '/') end

-- ============================================================
-- 扫描目录，返回匹配的 CompletionItem
-- ============================================================
function M._scan_dir(full_dir, partial, sep_char)
    local scan_dir = M._normalize_separators(full_dir)
    local handle = vim.uv.fs_scandir(scan_dir)
    if not handle then return {} end

    local show_hidden = vim.startswith(partial, '.')
    local items = {}
    while true do
        local name, ftype = vim.uv.fs_scandir_next(handle)
        if not name then break end
        if not show_hidden and vim.startswith(name, '.') then goto continue end
        if #partial > 0 and not vim.startswith(name, partial) then goto continue end

        local label = ftype == 'directory' and (name .. sep_char) or name
        table.insert(items, {
            label = label,
            kind = ftype == 'directory' and vim.lsp.protocol.CompletionItemKind.Folder
                or vim.lsp.protocol.CompletionItemKind.File,
            insertText = label,
        })
        ::continue::
    end

    table.sort(items, function(a, b)
        local a_dir = a.kind == vim.lsp.protocol.CompletionItemKind.Folder
        local b_dir = b.kind == vim.lsp.protocol.CompletionItemKind.Folder
        if a_dir ~= b_dir then return a_dir end
        return a.label:lower() < b.label:lower()
    end)

    return items
end

-- ============================================================
-- 获取路径补全候选项（对给定 word 和 buffer）
-- ============================================================
function M.get_completions(word, bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if not M.is_path(word) then return {} end

    -- 展开 ~
    if word:match '^~' then word = M._normalize_separators(vim.fn.expand '~') .. word:sub(2) end

    local dir_part, partial, sep_char = M._split_path(word)
    local base = M._resolve_base(bufnr, word)
    local full_dir = M._join_path(base, dir_part)

    return M._scan_dir(full_dir, partial, sep_char)
end

-- ============================================================
-- 在缓冲区上启用路径补全 LSP
-- ============================================================
function M.start(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    -- 不对未命名 buffer（如 :new / 启动默认 buffer）进行 attach
    local bufpath = vim.api.nvim_buf_get_name(bufnr)
    if bufpath == '' then return end

    -- 检查是否已附着
    for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
        if client.name == 'path-lsp' then return end
    end

    -- 确保当前 buffer 是目标 buffer（vim.lsp.start 会附着到当前 buffer）
    vim.api.nvim_set_current_buf(bufnr)

    -- 确定 root_dir：优先 .git 根目录，其次文件所在目录，最后 cwd
    local root_dir = vim.fs.root(bufnr, '.git') or vim.fs.dirname(bufpath) or vim.fn.getcwd()

    ---@diagnostic disable-next-line: missing-parameter
    vim.lsp.start {
        name = 'path-lsp',
        root_dir = root_dir,
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        cmd = function(dispatchers)
            local closing = false
            return {
                request = function(method, params, callback)
                    if method == 'initialize' then
                        callback(nil, {
                            capabilities = {
                                textDocumentSync = vim.lsp.protocol.TextDocumentSyncKind.Full,
                                completionProvider = {
                                    resolveProvider = false,
                                    triggerCharacters = { '/', '\\', '.' },
                                },
                            },
                            serverInfo = {
                                name = 'path-lsp',
                                version = '1.0.0',
                            },
                        })
                    elseif method == 'textDocument/completion' then
                        local uri = params.textDocument and params.textDocument.uri
                        local pos = params.position
                        if not uri or not pos then
                            callback(nil, nil)
                            return
                        end
                        -- 从 URI 解析 bufnr
                        local target_buf = uri and vim.uri_to_bufnr(uri)
                        if not target_buf or not vim.api.nvim_buf_is_valid(target_buf) then
                            callback(nil, nil)
                            return
                        end
                        -- 读取光标所在行
                        local lines = vim.api.nvim_buf_get_lines(target_buf, pos.line, pos.line + 1, false)
                        local line = lines[1] or ''
                        -- 提取路径单词
                        local word = M._extract_word_from_line(line, pos.character)
                        if not M.is_path(word) then
                            callback(nil, nil)
                            return
                        end
                        -- 计算 partial 长度，用于 textEdit range
                        local _, partial = M._split_path(word)
                        local items = M.get_completions(word, target_buf)
                        -- 为每个 item 添加 textEdit，确保 mini.completion 能正确确定替换范围
                        for _, item in ipairs(items) do
                            item.textEdit = {
                                range = {
                                    start = { line = pos.line, character = pos.character - #partial },
                                    ['end'] = { line = pos.line, character = pos.character },
                                },
                                newText = item.insertText,
                            }
                        end
                        callback(nil, #items > 0 and items or nil)
                    elseif method == 'shutdown' then
                        callback(nil, nil)
                    else
                        callback(nil, nil)
                    end
                end,
                notify = function(_method, _params) end,
                is_closing = function() return closing end,
                terminate = function()
                    if closing then return end
                    closing = true
                    dispatchers.on_exit(0, 0)
                end,
            }
        end,
    }
end

return M
