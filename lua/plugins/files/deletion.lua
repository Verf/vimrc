-- 直接从原路径回收，保留系统用于恢复的文件名和目录。
local fs = require 'plugins.files.fs'
local M = {}
local shell

local function recycle_windows(path)
    path = path:gsub('/', '\\')
    assert(path:match '^%a:\\' and not path:find '[*?]', '回收站需要本地磁盘路径: ' .. path)
    local ffi = require 'ffi'
    if not shell then
        if not pcall(ffi.typeof, 'FilesShellOperation') then
            -- shellapi.h 仅在 32 位上使用 1 字节对齐。
            if ffi.abi '32bit' then ffi.cdef '#pragma pack(push, 1)' end
            ffi.cdef [[
                typedef struct {
                    void *hwnd;
                    unsigned int operation;
                    const uint16_t *from;
                    const uint16_t *to;
                    uint16_t flags;
                    int aborted;
                    void *mappings;
                    const uint16_t *title;
                } FilesShellOperation;
                int __stdcall SHFileOperationW(FilesShellOperation *op);
                int __stdcall MultiByteToWideChar(unsigned int cp, unsigned long flags,
                    const char *src, int len, uint16_t *dst, int size);
            ]]
            if ffi.abi '32bit' then ffi.cdef '#pragma pack(pop)' end
        end
        shell = ffi.load 'shell32'
    end
    local convert = ffi.C.MultiByteToWideChar
    local len = convert(65001, 8, path, #path, nil, 0)
    assert(len > 0, '无法转换回收路径: ' .. path)
    -- pFrom 需要双 NUL 结尾的 UTF-16 字符串。
    local wide = ffi.new('uint16_t[?]', len + 2)
    assert(convert(65001, 8, path, #path, wide, len) == len, '无法转换回收路径: ' .. path)
    local op = ffi.new 'FilesShellOperation[1]'
    op[0].operation = 3 -- FO_DELETE
    op[0].from = wide
    -- 静默回收，不跟随重解析点或连带处理其他文件；不能回收时保留系统的永久删除警告。
    op[0].flags = 0x0004 + 0x0010 + 0x0040 + 0x2000 + 0x4000 + 0x8000
    local code = shell.SHFileOperationW(op)
    assert(code == 0 and op[0].aborted == 0, ('回收失败或已取消 (0x%X): %s'):format(code, path))
end

function M.select()
    if fs.windows then return { description = '删除将送入 Windows 回收站。', remove = recycle_windows } end
    for _, command in ipairs { { 'trash-put' }, { 'gio', 'trash' } } do
        local exe = vim.fn.exepath(command[1])
        if exe ~= '' then
            return {
                description = '删除将送入回收站（' .. table.concat(command, ' ') .. '）。',
                remove = function(path)
                    local args = vim.list_extend({ exe }, vim.list_slice(command, 2))
                    vim.list_extend(args, { '--', path })
                    local result = vim.system(args, { text = true }):wait()
                    assert(
                        result.code == 0,
                        ('回收失败 (%d): %s\n%s'):format(result.code, path, vim.trim(result.stderr or ''))
                    )
                end,
            }
        end
    end
    return { description = '未找到回收站工具，删除将永久生效，无法恢复。', remove = fs.remove }
end

return M
