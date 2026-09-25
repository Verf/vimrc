-- 每次刷新分配全新 ID，拒绝旧寄存器和其他目录的条目身份。
local fs = require 'plugins.files.fs'
local M = { buffers = {}, next_id = 0 }
-- 寄存器可能经 ShaDa 跨进程保留，随机前缀防止旧 ID 在新会话中碰巧复用。
local session_id = fs.must(vim.uv.random(8)):gsub('.', function(byte) return ('%03d'):format(byte:byte()) end)

function M.scan(root, hidden)
    local stat = assert(fs.stat(root), '目录不存在: ' .. root)
    assert(stat.type == 'directory', '不是目录: ' .. root)
    local snapshot = { root = root, dev = stat.dev, ino = stat.ino, entries = {}, ordered = {} }
    for _, name in ipairs(fs.list(root)) do
        if fs.key(name) ~= fs.key(fs.reserved) and (hidden or name:sub(1, 1) ~= '.') then
            local path = fs.join(root, name)
            local s = assert(fs.stat(path), '扫描期间条目消失，请刷新: ' .. name)
            M.next_id = M.next_id + 1
            local entry = {
                id = session_id .. ('%06d'):format(M.next_id),
                name = name,
                type = s.type,
                fingerprint = fs.fingerprint(path),
            }
            local valid = pcall(fs.validate_name, name)
            if not valid or not vim.tbl_contains({ 'file', 'directory', 'link' }, s.type) then
                snapshot.readonly = true
            end
            snapshot.entries[entry.id] = entry
            snapshot.ordered[#snapshot.ordered + 1] = entry
        end
    end
    table.sort(snapshot.ordered, function(a, b)
        if (a.type == 'directory') ~= (b.type == 'directory') then return a.type == 'directory' end
        return a.name < b.name
    end)
    return snapshot
end
return M
