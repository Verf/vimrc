-- 删除区与持久化日志同盘保存；失败日志永不自动清理。
local fs = require 'plugins.files.fs'
local uv = vim.uv
local M = {}

local function base(root, create)
    local path = fs.join(root, fs.reserved)
    local stat = fs.stat(path)
    if not stat and create then
        fs.must(uv.fs_mkdir(path, 448))
        stat = fs.stat(path)
    end
    assert(not stat or stat.type == 'directory', '暂存区不能是符号链接或文件')
    if stat then assert(stat.dev == fs.stat(root).dev, '暂存区必须与目录位于同一设备') end
    return path, stat
end
function M.save(tx)
    local path = fs.join(tx.path, 'journal.json')
    local tmp = path .. '.tmp'
    fs.write(tmp, vim.json.encode(tx.data))
    fs.must(uv.fs_rename(tmp, path))
end
function M.begin(plan)
    local parent = base(plan.root, true)
    local path = fs.must(uv.fs_mkdtemp(fs.join(parent, 'txn-XXXXXX')))
    local tx = {
        path = path,
        data = {
            version = 1,
            root = plan.root,
            status = 'running',
            time = os.date '!%Y-%m-%dT%H:%M:%SZ',
            ops = vim.deepcopy(plan.ops),
            lines = plan.lines,
            steps = {},
            deleted = {},
        },
    }
    M.save(tx)
    return tx
end
function M.list(root)
    local parent, stat = base(root)
    if not stat then return {} end
    local result = {}
    for _, name in ipairs(fs.list(parent)) do
        if name:match '^txn%-%w+$' then
            local path = fs.join(parent, name)
            local s = fs.stat(path)
            if s and s.type == 'directory' then
                local journal = fs.join(path, 'journal.json')
                local jstat = fs.stat(journal)
                if jstat and jstat.type == 'file' then
                    local ok, data = pcall(function() return vim.json.decode(fs.read(journal)) end)
                    if ok and data.version == 1 and data.root == root then
                        result[#result + 1] = { path = path, data = data }
                    end
                end
            end
        end
    end
    return result
end

local function validate(tx)
    assert(fs.canonical(tx.data.root) == tx.data.root, '原目录路径已改变')
    local parent, stat = base(tx.data.root)
    assert(stat, '暂存区已消失')
    local name = vim.fs.basename(tx.path)
    assert(name:match '^txn%-%w+$' and tx.path == fs.join(parent, name), '事务路径无效')
    assert(fs.stat(tx.path) and fs.stat(tx.path).type == 'directory', '事务目录已改变')
end
local function no_buffers(path)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        assert(name == '' or not fs.inside(name, path), '请先关闭此路径下的 buffer: ' .. name)
    end
end

function M.restore(tx)
    validate(tx)
    assert(tx.data.status == 'complete', '只自动恢复已完成事务；失败事务请根据日志手动恢复')
    local items = {}
    for _, item in ipairs(tx.data.deleted) do
        if not item.restored then
            assert(item.slot:match '^source%-%d+$', '日志暂存路径无效')
            fs.validate_name(item.name)
            assert(not item.name:find('/', 1, true), '日志原路径无效')
            local src, dst = fs.join(tx.path, item.slot), fs.join(tx.data.root, item.name)
            assert(fs.stat(src), '暂存条目不存在: ' .. src)
            assert(not fs.stat(dst), '恢复目标已存在: ' .. dst)
            no_buffers(dst)
            items[#items + 1] = { item = item, src = src, dst = dst }
        end
    end
    assert(#items > 0, '没有待恢复条目')
    for _, entry in ipairs(items) do
        tx.data.pending_restore = entry.item.name
        M.save(tx)
        fs.rename(entry.src, entry.dst)
        entry.item.restored = true
        tx.data.pending_restore = nil
        M.save(tx)
    end
end

function M.clean(tx)
    validate(tx)
    assert(tx.data.status == 'complete' and not tx.data.pending_restore, '不能清理失败或未完成的事务')
    no_buffers(tx.path)
    fs.remove(tx.path)
end
return M
