-- 纯文本解析与计划生成；执行器再次校验，预览本身不会改动磁盘。
local fs = require 'plugins.files.fs'
local M = {}

function M.parse(lines, snapshot)
    local rows, targets, occurrences = {}, {}, {}
    for line, text in ipairs(lines) do
        if text ~= '' then
            local id, name = text:match '^/(%d+) (.*)$'
            assert(text:sub(1, 1) ~= '/' or id, ('第 %d 行 ID 格式损坏'):format(line))
            name = name or text
            local directory = name:sub(-1) == '/'
            if directory then name = name:sub(1, -2) end
            local ok, err = pcall(fs.validate_name, name)
            assert(ok, ('第 %d 行: %s'):format(line, err or ''))
            local entry = id and snapshot.entries[id]
            assert(not id or entry, ('第 %d 行 ID 未知（不支持跨目录粘贴）'):format(line))
            assert(not entry or directory == (entry.type == 'directory'), '不能通过增删 / 改变条目类型')
            local key = fs.key(name)
            assert(not targets[key], '重复目标: ' .. name)
            local row = { id = id, name = name, directory = directory, line = line }
            rows[#rows + 1], targets[key] = row, row
            if id then
                occurrences[id] = occurrences[id] or {}
                table.insert(occurrences[id], row)
            end
        end
    end
    return rows, occurrences
end

function M.build(lines, snapshot)
    local rows, occurrences = M.parse(lines, snapshot)
    local plan = { root = snapshot.root, ops = {}, snapshot = snapshot, lines = lines }
    local function add(kind, entry, row)
        plan.ops[#plan.ops + 1] = {
            kind = kind,
            id = entry and entry.id,
            src = entry and fs.join(snapshot.root, entry.name),
            dst = row and fs.join(snapshot.root, row.name),
            relative = row and row.name,
            directory = row and row.directory,
        }
    end
    for _, entry in ipairs(snapshot.ordered) do
        local refs = occurrences[entry.id] or {}
        if #refs == 0 then
            add('delete', entry)
        else
            local original
            for _, row in ipairs(refs) do
                if row.name == entry.name then original = row end
            end
            assert(original or #refs == 1, '同一 ID 的多个新位置有歧义: ' .. entry.name)
            for _, row in ipairs(refs) do
                if row ~= original then add(original and 'copy' or 'move', entry, row) end
            end
        end
    end
    for _, row in ipairs(rows) do
        if not row.id then add('create', nil, row) end
    end
    M.validate(plan)
    return plan
end

function M.validate(plan)
    local root = assert(fs.stat(plan.root), '目录已消失')
    assert(root.type == 'directory' and fs.canonical(plan.root) == plan.root, '目录路径已改变')
    assert(root.dev == plan.snapshot.dev and root.ino == plan.snapshot.ino, '目录已被替换，请刷新')
    local vacated, moving = {}, {}
    for _, op in ipairs(plan.ops) do
        if op.kind == 'move' or op.kind == 'delete' then vacated[fs.key(op.src)] = true end
        if op.src then
            assert(
                fs.fingerprint(op.src) == plan.snapshot.entries[op.id].fingerprint,
                '源条目已在外部改变，请刷新: ' .. op.src
            )
            local s = assert(fs.stat(op.src))
            assert(s.dev == root.dev, '首版不支持跨设备操作: ' .. op.src)
            if op.kind == 'move' or op.kind == 'delete' then moving[#moving + 1] = op.src end
        end
    end
    for _, op in ipairs(plan.ops) do
        if op.dst then
            assert(
                not op.src or not fs.inside(op.dst, op.src) or fs.key(op.dst) == fs.key(op.src),
                '不能复制或移动到自身内部: ' .. op.dst
            )
            fs.check_parent(plan.root, op.relative)
            assert(not fs.stat(op.dst) or vacated[fs.key(op.dst)], '目标已存在: ' .. op.dst)
            -- 首版不在移动/删除的目录下面同时创建其他条目。
            for _, path in ipairs(moving) do
                assert(
                    fs.key(op.dst) == fs.key(path) or not fs.inside(op.dst, path),
                    '不支持在移动/删除的源目录内部写入: ' .. op.dst
                )
            end
            local parent = vim.fs.dirname(op.dst)
            while not fs.stat(parent) do
                parent = vim.fs.dirname(parent)
            end
            assert(fs.stat(parent).dev == root.dev, '首版不支持跨设备操作: ' .. op.dst)
            for _, other in ipairs(plan.ops) do
                if other ~= op and other.dst and fs.inside(op.dst, other.dst) then
                    assert(other.kind == 'create' and other.directory, '目标路径嵌套冲突: ' .. op.dst)
                end
            end
        end
    end
end

function M.describe(plan)
    local lines = {}
    for _, op in ipairs(plan.ops) do
        local src = op.src and vim.fs.basename(op.src) or ''
        local dst = op.relative or ''
        lines[#lines + 1] = ('%-6s %s%s%s'):format(op.kind:upper(), src, op.src and op.dst and ' → ' or '', dst)
    end
    return lines
end
return M
