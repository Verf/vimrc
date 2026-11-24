-- nvim --headless -u NONE -l tests/files/run.lua
vim.opt.runtimepath:prepend(vim.fn.getcwd())
local fs = require 'plugins.files.fs'
local state = require 'plugins.files.state'
local planner = require 'plugins.files.planner'
local executor = require 'plugins.files.executor'
local deletion = require 'plugins.files.deletion'
local select_deletion = deletion.select
-- 不污染运行测试的用户回收站。
deletion.select = function() return { description = '测试：永久删除。', remove = fs.remove } end
local view = require 'plugins.files.view'
local files = require 'plugins.files'
files.setup()
local sandbox = vim.fn.tempname()
vim.fn.mkdir(sandbox, 'p')
sandbox = fs.canonical(sandbox)
local count = 0
local function eq(a, b) assert(vim.deep_equal(a, b), vim.inspect(a) .. ' ~= ' .. vim.inspect(b)) end
local function rejects(fn, pattern)
    local ok, err = pcall(fn)
    assert(not ok, 'expected rejection')
    if pattern then assert(tostring(err):find(pattern, 1, true), tostring(err)) end
end
local function test(name, fn)
    count = count + 1
    local root = fs.join(sandbox, tostring(count))
    vim.fn.mkdir(root, 'p')
    local ok, err = xpcall(function() fn(root) end, debug.traceback)
    if not ok then
        io.stderr:write('FAIL ' .. name .. '\n' .. err .. '\nSandbox: ' .. sandbox .. '\n')
        vim.cmd 'cquit 1'
    end
    print('PASS ' .. name)
end
local function put(root, name, text)
    local path = fs.join(root, name)
    vim.fn.mkdir(vim.fs.dirname(path), 'p')
    fs.write(path, text or name, true)
    return path
end
local function snapshot(root) return state.scan(root, true) end
local function line(s, original, target)
    for _, entry in ipairs(s.ordered) do
        if entry.name == original then
            return '/' .. entry.id .. ' ' .. (target or original) .. (entry.type == 'directory' and '/' or '')
        end
    end
    error('missing snapshot entry: ' .. original)
end
local function apply(s, lines)
    local p = planner.build(lines, s)
    local ok, msg = executor.execute(p, executor.prepare(p))
    assert(ok, msg)
end

test('create nested files and explicit directories independent of order', function(root)
    apply(snapshot(root), { 'a/b.txt', 'a/', 'empty/' })
    eq(fs.read(fs.join(root, 'a/b.txt')), '')
    eq(fs.stat(fs.join(root, 'empty')).type, 'directory')
end)
test('rename preserves bytes; copy keeps source', function(root)
    put(root, 'a', 'hello')
    local s = snapshot(root)
    apply(s, { line(s, 'a', 'b') })
    eq(fs.stat(fs.join(root, 'a')), nil)
    eq(fs.read(fs.join(root, 'b')), 'hello')
    s = snapshot(root)
    apply(s, { line(s, 'b'), line(s, 'b', 'copy') })
    eq(fs.read(fs.join(root, 'copy')), 'hello')
    eq(fs.read(fs.join(root, 'b')), 'hello')
end)
test('cyclic rename and copy before moved targets', function(root)
    put(root, 'a', 'AAA')
    put(root, 'b', 'BBB')
    local s = snapshot(root)
    apply(s, { line(s, 'a', 'b'), line(s, 'b', 'a') })
    eq(fs.read(fs.join(root, 'a')), 'BBB')
    eq(fs.read(fs.join(root, 'b')), 'AAA')
end)
test('directory copy and recursive deletion leave no private trash', function(root)
    put(root, 'folder/nested/a', 'payload')
    local s = snapshot(root)
    apply(s, { line(s, 'folder'), line(s, 'folder', 'copy') })
    eq(fs.read(fs.join(root, 'copy/nested/a')), 'payload')
    s = snapshot(root)
    apply(s, { line(s, 'folder') })
    eq(fs.list(root), { 'folder' })
end)
test('legacy trash stays untouched and hidden', function(root)
    local old = put(root, '.nvim-files-trash/txn-old/source-1', 'old')
    put(root, 'a')
    apply(snapshot(root), {})
    eq(fs.list(root), { '.nvim-files-trash' })
    eq(fs.read(old), 'old')
    eq(vim.fn.exists ':FilesRestore', 0)
    eq(vim.fn.exists ':FilesClean', 0)
end)
test('deletion backend picks a tool, passes literal paths and does not fall back on failure', function(root)
    local original_exepath, system, windows = vim.fn.exepath, vim.system, fs.windows
    local source = put(root, "-path with spaces & 'quotes'")
    local available = {}
    fs.windows = false
    vim.fn.exepath = function(tool) return available[tool] or '' end
    eq(select_deletion().remove, fs.remove)
    assert(select_deletion().description:find('永久', 1, true))
    fs.windows = true
    assert(select_deletion().description:find('Windows', 1, true))
    fs.windows = false
    available = { gio = '/bin/gio', ['trash-put'] = '/bin/trash-put' }
    local args
    vim.system = function(argv)
        args = argv
        return { wait = function() return { code = 1, stderr = 'trash unavailable' } end }
    end
    rejects(function() select_deletion().remove(source) end, 'trash unavailable')
    eq(args, { '/bin/trash-put', '--', source })
    available['trash-put'] = nil
    rejects(function() select_deletion().remove(source) end, 'trash unavailable')
    eq(args, { '/bin/gio', 'trash', '--', source })
    vim.fn.exepath, vim.system, fs.windows = original_exepath, system, windows
    assert(fs.stat(source))
end)
test('hidden entries are not inferred as deletions', function(root)
    put(root, '.secret', 'safe')
    put(root, 'visible')
    local s = state.scan(root, false)
    apply(s, {})
    eq(fs.read(fs.join(root, '.secret')), 'safe')
end)
test('line reorder does nothing', function(root)
    put(root, 'a')
    put(root, 'b')
    local s = snapshot(root)
    eq(#planner.build({ line(s, 'b'), line(s, 'a') }, s).ops, 0)
end)
test('invalid IDs, duplicate destinations, ambiguous copies', function(root)
    put(root, 'a')
    local s = snapshot(root)
    rejects(function() planner.build({ '/999999 a' }, s) end, 'ID 未知')
    rejects(function() planner.build({ '/x a' }, s) end, 'ID 格式')
    rejects(function() planner.build({ line(s, 'a'), 'a' }, s) end, '重复目标')
    rejects(function() planner.build({ line(s, 'a', 'b'), line(s, 'a', 'c') }, s) end, '歧义')
    local old = line(s, 'a')
    rejects(function() planner.build({ old }, snapshot(root)) end, 'ID 未知')
end)
test('unsafe paths and nested source/target conflicts', function(root)
    put(root, 'folder/a')
    local s = snapshot(root)
    local invalid =
        { '../escape', '/absolute', 'a/../b', 'a//b', 'a\\b', '.nvim-files-trash/x', '.nvim-files-stage-abc/x', 'a\nb' }
    for _, name in ipairs(invalid) do
        rejects(function() planner.build({ line(s, 'folder'), name }, s) end)
    end
    rejects(function() planner.build({ line(s, 'folder'), line(s, 'folder', 'folder/copy') }, s) end, '自身内部')
    rejects(function() planner.build({ line(s, 'folder', 'folder/sub') }, s) end, '自身内部')
    rejects(function() planner.build({ line(s, 'folder', 'new'), 'folder/new' }, s) end, '源目录内部')
end)
test('target collisions never overwrite hidden files', function(root)
    put(root, 'a')
    put(root, '.hidden', 'safe')
    local s = state.scan(root, false)
    rejects(function() planner.build({ line(s, 'a', '.hidden') }, s) end, '目标已存在')
    eq(fs.read(fs.join(root, '.hidden')), 'safe')
end)
test('external source changes invalidate plans', function(root)
    put(root, 'a', 'before')
    local s = snapshot(root)
    fs.write(fs.join(root, 'a'), 'after and longer')
    rejects(function() planner.build({ line(s, 'a', 'b') }, s) end, '外部改变')
end)
test('changes during confirmation are detected recursively', function(root)
    put(root, 'folder/a', 'before')
    local p = planner.build({}, snapshot(root))
    local expected = executor.prepare(p)
    fs.write(fs.join(root, 'folder/a'), 'changed')
    rejects(function() executor.execute(p, expected) end, '确认期间')
    assert(fs.stat(fs.join(root, 'folder')))
end)
test('symlink copy/delete operates on link, destination parents cannot be links', function(root)
    if fs.windows then return end
    local outside = fs.join(sandbox, 'outside')
    vim.fn.mkdir(outside, 'p')
    put(outside, 'safe', 'untouched')
    fs.must(vim.uv.fs_symlink(outside, fs.join(root, 'link')))
    local s = snapshot(root)
    rejects(function() planner.build({ line(s, 'link'), 'link/new' }, s) end, '父路径不是普通目录')
    apply(s, { line(s, 'link'), line(s, 'link', 'copy') })
    eq(fs.stat(fs.join(root, 'copy')).type, 'link')
    apply(snapshot(root), {})
    eq(fs.read(fs.join(outside, 'safe')), 'untouched')
end)
test('dirty file buffers block operations', function(root)
    local path = put(root, 'a')
    vim.cmd.edit(vim.fn.fnameescape(path))
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { 'unsaved' })
    local buf = vim.api.nvim_get_current_buf()
    local p = planner.build({}, snapshot(root))
    rejects(function() executor.prepare(p) end, '未保存')
    vim.api.nvim_buf_delete(buf, { force = true })
    eq(fs.read(path), 'a')
end)
test('loaded buffers follow directory moves and cyclic renames', function(root)
    local a, b = put(root, 'a', 'A'), put(root, 'b', 'B')
    local ba, bb = vim.fn.bufadd(a), vim.fn.bufadd(b)
    vim.fn.bufload(ba)
    vim.fn.bufload(bb)
    local s = snapshot(root)
    apply(s, { line(s, 'a', 'b'), line(s, 'b', 'a') })
    eq(vim.api.nvim_buf_get_name(ba), b)
    eq(vim.api.nvim_buf_get_name(bb), a)
    vim.api.nvim_buf_delete(ba, { force = false })
    vim.api.nvim_buf_delete(bb, { force = false })
end)
test('failure rolls back staged moves and skips deletion', function(root)
    put(root, 'a')
    put(root, 'b')
    put(root, 'will-not-delete')
    local s = snapshot(root)
    local p = planner.build({ line(s, 'a', 'renamed'), line(s, 'b'), line(s, 'b', 'copy') }, s)
    local expected = executor.prepare(p)
    local copy = fs.copy
    fs.copy = function() error 'injected failure' end
    local ok, msg = executor.execute(p, expected)
    fs.copy = copy
    eq(ok, false)
    assert(msg:find('injected failure', 1, true))
    eq(fs.read(fs.join(root, 'a')), 'a')
    eq(fs.list(root), { 'a', 'b', 'will-not-delete' })
end)
test('deletion uses original path before moving a replacement into place', function(root)
    local a = put(root, 'a', 'old')
    local b = put(root, 'b', 'new')
    local ba, bb = vim.fn.bufadd(a), vim.fn.bufadd(b)
    vim.fn.bufload(ba)
    vim.fn.bufload(bb)
    local s = snapshot(root)
    local p = planner.build({ line(s, 'b', 'a') }, s)
    local expected = executor.prepare(p)
    expected.deletion.remove = function(path)
        eq(path, a)
        eq(fs.read(path), 'old')
        fs.remove(path)
    end
    local ok, msg = executor.execute(p, expected)
    assert(ok, msg)
    eq(vim.api.nvim_buf_is_valid(ba), false)
    eq(vim.api.nvim_buf_get_name(bb), a)
    eq(fs.read(a), 'new')
    eq(fs.list(root), { 'a' })
    vim.api.nvim_buf_delete(bb, { force = false })
end)
test('partial deletion failure reports completed deletes and rolls back other changes', function(root)
    local a, b = put(root, 'a'), put(root, 'b')
    local s = snapshot(root)
    local p = planner.build({ 'new' }, s)
    local expected = executor.prepare(p)
    expected.deletion.remove = function(path)
        if path == b then error 'trash failure' end
        fs.remove(path)
    end
    local ok, msg = executor.execute(p, expected)
    eq(ok, false)
    assert(msg:find('trash failure', 1, true) and msg:find('已删除，未回滚:\n' .. a, 1, true), msg)
    eq(fs.list(root), { 'b' })
end)
test('directory buffer setup, canceled save, commit and undo boundary', function(root)
    put(root, 'a')
    local buf = files.open(root)
    eq(vim.bo[buf].buftype, 'acwrite')
    eq(vim.bo[buf].filetype, 'files')
    eq(vim.bo[buf].buflisted, false)
    local s = state.buffers[buf]
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { line(s.snapshot, 'a', 'b') })
    local confirm = view.confirm
    view.confirm = function() return false end
    rejects(function() view.write(buf) end, '已取消')
    assert(vim.bo[buf].modified)
    eq(fs.read(fs.join(root, 'a')), 'a')
    view.confirm = function() return true end
    vim.cmd 'write'
    view.confirm = confirm
    eq(vim.bo[buf].modified, false)
    eq(fs.read(fs.join(root, 'b')), 'a')
    local saved = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    vim.cmd 'silent undo'
    eq(vim.api.nvim_buf_get_lines(buf, 0, -1, false), saved)
    vim.api.nvim_buf_delete(buf, { force = false })
end)
test('directory :edit takeover and window option restoration', function(root)
    put(root, 'a')
    vim.cmd 'enew'
    vim.wo.wrap, vim.wo.conceallevel = true, 0
    vim.cmd.edit(vim.fn.fnameescape(root))
    eq(vim.bo.filetype, 'files')
    eq(vim.wo.wrap, false)
    local buf = vim.api.nvim_get_current_buf()
    vim.cmd.edit(vim.fn.fnameescape(fs.join(root, 'a')))
    eq(vim.wo.wrap, true)
    eq(vim.wo.conceallevel, 0)
    vim.api.nvim_buf_delete(buf, { force = false })
end)
test('unsupported filenames produce a read-only directory', function(root)
    if fs.windows then return end
    put(root, 'newline\nname')
    local buf = files.open(root)
    eq(vim.bo[buf].modifiable, false)
    rejects(function() view.write(buf) end, '只读')
    vim.api.nvim_buf_delete(buf, { force = true })
end)
test('global autosave never commits directory edits', function(root)
    _G.MyGroup = vim.api.nvim_create_augroup('FilesIntegrationTest', { clear = true })
    dofile 'plugin/30_autocmds.lua'
    local buf = files.open(root)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { 'not-created' })
    vim.api.nvim_exec_autocmds('FocusLost', {})
    eq(fs.stat(fs.join(root, 'not-created')), nil)
    assert(vim.bo[buf].modified)
    vim.api.nvim_buf_delete(buf, { force = true })
end)
test('split inherits original window options and restores them on file open', function(root)
    put(root, 'a')
    vim.cmd 'enew'
    vim.wo.wrap, vim.wo.conceallevel = true, 0
    local buf = files.open(root)
    local old_win = vim.api.nvim_get_current_win()
    view.select 'vertical'
    eq(vim.wo.wrap, true)
    eq(vim.wo.conceallevel, 0)
    eq(vim.wo[old_win].wrap, false)
    vim.cmd 'close'
    vim.api.nvim_buf_delete(buf, { force = false })
end)
test('unloaded directory and restored URI rescan safely', function(root)
    put(root, 'a')
    local buf = files.open(root)
    local name = vim.api.nvim_buf_get_name(buf)
    vim.cmd 'enew'
    vim.api.nvim_buf_delete(buf, { force = false })
    put(root, 'b')
    buf = files.open(root)
    eq(#state.buffers[buf].snapshot.ordered, 2)
    vim.api.nvim_buf_delete(buf, { force = true })
    vim.cmd.edit(vim.fn.fnameescape(name))
    eq(vim.bo.filetype, 'files')
    eq(#state.buffers[vim.api.nvim_get_current_buf()].snapshot.ordered, 2)
    vim.api.nvim_buf_delete(0, { force = true })
end)
test('directory rename updates descendant file buffer names', function(root)
    local path = put(root, 'old/deep/a', 'contents')
    local buf = vim.fn.bufadd(path)
    vim.fn.bufload(buf)
    local s = snapshot(root)
    apply(s, { line(s, 'old', 'new') })
    eq(vim.api.nvim_buf_get_name(buf), fs.join(root, 'new/deep/a'))
    eq(fs.read(fs.join(root, 'new/deep/a')), 'contents')
    vim.api.nvim_buf_delete(buf, { force = false })
end)
test('uncommitted descendant directory blocks deletion', function(root)
    put(root, 'child/a')
    local buf = files.open(fs.join(root, 'child'))
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { 'pending' })
    local p = planner.build({}, snapshot(root))
    rejects(function() executor.prepare(p) end, '未提交的目录')
    vim.api.nvim_buf_delete(buf, { force = true })
end)
test('partial copy failure preserves evidence and original sources', function(root)
    put(root, 'a')
    put(root, 'b')
    local s = snapshot(root)
    local p = planner.build({ line(s, 'a', 'moved'), line(s, 'b'), line(s, 'b', 'partial') }, s)
    local expected, original = executor.prepare(p), fs.copy
    fs.copy = function(_, dst)
        fs.write(dst, 'partial data', true)
        error 'partial copy failure'
    end
    local ok, msg = executor.execute(p, expected)
    fs.copy = original
    eq(ok, false)
    eq(fs.read(fs.join(root, 'a')), 'a')
    eq(fs.read(fs.join(root, 'partial')), 'partial data')
    assert(msg:find('partial copy failure', 1, true))
    eq(fs.list(root), { 'a', 'b', 'partial' })
end)
test('failed commit locks the view until explicit refresh', function(root)
    put(root, 'a')
    local buf = files.open(root)
    local s = state.buffers[buf]
    vim.api.nvim_buf_set_lines(buf, -1, -1, false, { line(s.snapshot, 'a', 'copy') })
    local original, confirm = fs.copy, view.confirm
    fs.copy = function() error 'copy failure' end
    view.confirm = function() return true end
    rejects(function() view.write(buf) end, '提交失败')
    fs.copy, view.confirm = original, confirm
    eq(s.failed, true)
    eq(vim.bo[buf].modifiable, false)
    assert(vim.bo[buf].modified)
    rejects(function() view.write(buf) end, '上次提交失败')
    view.render(s)
    eq(s.failed, false)
    eq(vim.bo[buf].modifiable, true)
    vim.api.nvim_buf_delete(buf, { force = false })
end)
test('file types, Windows names and root containment', function(root)
    put(root, 'a')
    local s = snapshot(root)
    rejects(function() planner.build({ line(s, 'a') .. '/' }, s) end, '条目类型')
    rejects(function() planner.build({ line(s, 'a'), 'double//' }, s) end, '空组件')
    assert(fs.inside('/a', '/'))
    assert(not fs.inside('/ab', '/a'))
    local windows = fs.windows
    fs.windows = true
    for _, name in ipairs { 'CON', 'COM1.txt', 'trailing.', 'file:stream', 'a?' } do
        rejects(function() fs.validate_name(name) end)
    end
    eq(fs.key 'A.txt', fs.key 'a.txt')
    fs.windows = windows
end)
test('delete confirmation describes the chosen backend', function(root)
    local path = put(root, 'a')
    local buf = files.open(root)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
    local confirm = view.confirm
    view.confirm = function(_, _, note)
        eq(note, '测试：永久删除。')
        return false
    end
    rejects(function() view.write(buf) end, '已取消')
    view.confirm = confirm
    eq(fs.read(path), 'a')
    vim.api.nvim_buf_delete(buf, { force = true })
end)
test('unwritable staging area does not delete the source', function(root)
    if fs.windows or vim.uv.getuid() == 0 then return end
    put(root, 'a')
    local s = snapshot(root)
    local p = planner.build({ line(s, 'a', 'moved') }, s)
    local expected = executor.prepare(p)
    fs.must(vim.uv.fs_chmod(root, 365))
    local ok, err = executor.execute(p, expected)
    fs.must(vim.uv.fs_chmod(root, 493))
    assert(not ok and tostring(err):find('EACCES', 1, true), tostring(err))
    eq(fs.read(fs.join(root, 'a')), 'a')
end)
vim.fn.delete(sandbox, 'rf')
print(('All %d Files tests passed'):format(count))
vim.cmd 'qa!'
