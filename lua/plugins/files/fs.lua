-- 本地文件系统边界：不调用 shell，不沿符号链接递归。
local M = {}
local uv = vim.uv
M.windows = uv.os_uname().sysname == 'Windows_NT'
M.reserved = '.nvim-files-trash'

function M.join(a, b) return vim.fs.joinpath(a, b) end
function M.key(path)
    path = vim.fs.normalize(path)
    return M.windows and path:lower() or path
end
function M.inside(path, parent)
    path, parent = M.key(path), M.key(parent)
    local prefix = parent:gsub('/$', '') .. '/'
    return path == parent or path:sub(1, #prefix) == prefix
end
function M.stat(path)
    local stat, err, code = uv.fs_lstat(path)
    if not stat and code ~= 'ENOENT' and code ~= 'ENOTDIR' then error(err) end
    return stat
end
function M.must(value, err)
    if not value then error(err or '文件操作失败', 0) end
    return value
end
function M.fingerprint(path)
    local s = M.stat(path)
    if not s then return nil end
    return table.concat(
        { s.type, s.dev, s.ino, s.size, s.mode, s.mtime.sec, s.mtime.nsec, s.ctime.sec, s.ctime.nsec },
        ':'
    )
end
function M.list(path)
    local handle = M.must(uv.fs_scandir(path))
    local names = {}
    while true do
        local name = uv.fs_scandir_next(handle)
        if not name then break end
        names[#names + 1] = name
    end
    table.sort(names)
    return names
end
function M.canonical(path) return vim.fs.normalize(M.must(uv.fs_realpath(vim.fn.fnamemodify(path, ':p')))) end

-- 对未支持的名称拒绝编辑，避免平台相关的路径别名和转义歧义。
function M.validate_name(name)
    assert(name ~= '' and not name:find '[%z\1-\31\127\\]', '文件名包含不支持的字符')
    assert(not name:match '^/' and not name:match '^%a:', '只允许相对路径')
    assert(not name:find('//', 1, true) and name:sub(-1) ~= '/', '路径含空组件')
    for part in name:gmatch '[^/]+' do
        assert(part ~= '.' and part ~= '..' and M.key(part) ~= M.key(M.reserved), '路径包含保留组件: ' .. part)
        if M.windows then
            assert(not part:find '[<>:"|?*]' and not part:match '[ .]$', 'Windows 不支持此名称')
            local stem = (part:match '^[^.]+' or ''):upper()
            assert(
                not vim.tbl_contains({ 'CON', 'PRN', 'AUX', 'NUL' }, stem)
                    and not stem:match '^COM[1-9]$'
                    and not stem:match '^LPT[1-9]$',
                'Windows 保留名称'
            )
        end
    end
end

-- 逐组件检查，禁止通过符号链接父目录写入其他位置。
function M.check_parent(root, relative)
    local parts = vim.split(relative, '/', { plain = true })
    local path = root
    for i = 1, #parts - 1 do
        path = M.join(path, parts[i])
        local s = M.stat(path)
        assert(not s or s.type == 'directory', '父路径不是普通目录: ' .. path)
    end
end

function M.write(path, content, exclusive)
    local fd = M.must(uv.fs_open(path, exclusive and 'wx' or 'w', 384))
    local ok, err = pcall(function()
        local offset = 0
        while offset < #content do
            local n = M.must(uv.fs_write(fd, content:sub(offset + 1), offset))
            assert(n > 0, '写入没有进展')
            offset = offset + n
        end
        M.must(uv.fs_fsync(fd))
    end)
    local closed, close_err = uv.fs_close(fd)
    if not ok then error(err, 0) end
    M.must(closed, close_err)
end
function M.read(path)
    local fd = M.must(uv.fs_open(path, 'r', 0))
    local ok, content = pcall(function()
        local size = M.must(uv.fs_fstat(fd)).size
        assert(size < 16 * 1024 * 1024, '日志过大')
        return M.must(uv.fs_read(fd, size, 0))
    end)
    uv.fs_close(fd)
    if not ok then error(content, 0) end
    return content
end
function M.rename(src, dst)
    assert(not M.stat(dst), '目标已存在: ' .. dst)
    M.must(uv.fs_rename(src, dst))
end
function M.copy(src, dst)
    assert(not M.stat(dst), '目标已存在: ' .. dst)
    local s = assert(M.stat(src), '源路径已消失: ' .. src)
    if s.type == 'file' then
        M.must(uv.fs_copyfile(src, dst, { excl = true }))
    elseif s.type == 'directory' then
        M.must(uv.fs_mkdir(dst, 448))
        for _, name in ipairs(M.list(src)) do
            M.copy(M.join(src, name), M.join(dst, name))
        end
        M.must(uv.fs_chmod(dst, s.mode % 512))
    elseif s.type == 'link' and not M.windows then
        M.must(uv.fs_symlink(M.must(uv.fs_readlink(src)), dst))
    else
        error('不支持复制此类型: ' .. src)
    end
end
function M.remove(path)
    local s = M.stat(path)
    if not s then return end
    if s.type == 'directory' then
        for _, name in ipairs(M.list(path)) do
            M.remove(M.join(path, name))
        end
        M.must(uv.fs_rmdir(path))
    else
        M.must(uv.fs_unlink(path))
    end
end

-- 提交确认前后检查整个操作源，避免确认窗口期间目录内容改变。
function M.tree(path, result, depth, device)
    result, depth = result or {}, depth or 0
    assert(depth < 100, '目录层级过深')
    result[#result + 1] = { path, M.fingerprint(path) }
    assert(#result <= 10000, '单个源超过 10000 条目，请拆分操作')
    local s = assert(M.stat(path), '源路径已消失: ' .. path)
    device = device or s.dev
    assert(s.dev == device, '不支持操作嵌套挂载点: ' .. path)
    assert(s.type == 'file' or s.type == 'directory' or s.type == 'link', '不支持特殊文件: ' .. path)
    if s.type == 'directory' then
        for _, name in ipairs(M.list(path)) do
            M.tree(M.join(path, name), result, depth + 1, device)
        end
    end
    return result
end
return M
