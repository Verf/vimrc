-- 50_gtd.lua -- 极简 GTD 管理插件

-- 用法:
--   :GTDList     -- 扫描所有 todo.md，按 DEADLINE 升序填充 quickfix
--   :GTDToggle   -- 在当前行切换 TODO ↔ DONE

local M = {}

-- 默认配置
M.config = {
    todo_dir = nil,
    todo_file = 'todo.md',
    mappings = {
        show_todos = '<leader>ns',
        toggle_status = '<leader>nt',
    },
}

-- ============================================================
-- 解析一行文本，提取 GTD 信息
--
-- 支持的格式:
--   # TODO 标题 DEADLINE:<2026-05-26>
--   # DONE 标题 DEADLINE:<2026-05-26> CLOSED:<2026-05-26 14:00:00>
--   # TODO 标题 （无 DEADLINE，长期任务）
--
-- 返回 nil 或 { status, title, deadline, closed }
-- ============================================================
function M.parse_line(line)
    if not line then return nil end

    -- 匹配 # TODO / # DONE 开头
    local status, rest = line:match '^#%s+(TODO)%s+(.*)'
    if not status then
        status, rest = line:match '^#%s+(DONE)%s+(.*)'
    end
    if not status then return nil end

    -- 提取 DEADLINE 和 CLOSED 标签
    local deadline = rest:match 'DEADLINE:%s*<(%d+%-%d+%-%d+)>'
    local closed = rest:match 'CLOSED:%s*<(%d+%-%d+%-%d+ %d+:%d+:%d+)>'

    -- 从 rest 中移除标签，剩下的就是纯标题
    local title = rest
    title = title:gsub('%s*DEADLINE:%s*<%d+%-%d+%-%d+>%s*', ' ')
    title = title:gsub('%s*CLOSED:%s*<%d+%-%d+%-%d+ %d+:%d+:%d+>%s*', ' ')
    title = title:gsub('%s+$', ''):gsub('^%s+', '')

    return {
        status = status,
        title = title,
        deadline = deadline,
        closed = closed,
    }
end

-- ============================================================
-- 构建一行 GTD 文本
-- ============================================================
function M.build_line(parsed)
    local parts = { '# ' .. parsed.status, parsed.title }

    if parsed.deadline then table.insert(parts, 'DEADLINE:<' .. parsed.deadline .. '>') end
    if parsed.closed then table.insert(parts, 'CLOSED:<' .. parsed.closed .. '>') end

    return table.concat(parts, ' ')
end

-- ============================================================
-- 扫描所有 todo.md，填充 quickfix 列表
-- 排序: 有 DEADLINE 的按日期升序（越紧迫越靠前），无 DEADLINE 的排在最后
-- ============================================================
function M.set_todos_to_quickfix()
    if M.config.todo_dir == nil then return end

    local items = {}
    local pattern = vim.fs.joinpath(M.config.todo_dir, '**', M.config.todo_file)
    local files = vim.fn.glob(pattern, false, true)

    for _, file in ipairs(files) do
        local lines = vim.fn.readfile(file)
        for lnum, line in ipairs(lines) do
            local parsed = M.parse_line(line)
            if parsed and parsed.status == 'TODO' then
                table.insert(items, {
                    filename = file,
                    lnum = lnum,
                    col = 1,
                    text = line,
                    -- 额外字段仅用于排序，稍后清理
                    _deadline = parsed.deadline,
                })
            end
        end
    end

    if #items == 0 then
        vim.fn.setqflist({})
        vim.notify('[GTD] 未找到任何 TODO 任务', vim.log.levels.INFO)
        return
    end

    -- 排序: DEADLINE 升序（越紧迫越靠前），无 DEADLINE 的排在最后
    table.sort(items, function(a, b)
        local da, db = a._deadline, b._deadline

        if da and db then
            return da < db
        elseif da and not db then
            return true
        elseif not da and db then
            return false
        else
            return (a.filename .. a.lnum) < (b.filename .. b.lnum)
        end
    end)

    -- 清理临时字段
    for _, item in ipairs(items) do
        item._deadline = nil
    end

    vim.fn.setqflist(items, 'r')
end

function M.show_todos()
    if M.config.todo_dir == nil then return end

    M.set_todos_to_quickfix()
    vim.cmd 'copen'
end

-- ============================================================
-- 切换当前行的 TODO ↔ DONE 状态
-- 支持在普通缓冲区或 quickfix 窗口中调用
-- ============================================================
function M.toggle_status()
    local bufnr = vim.api.nvim_get_current_buf()
    local lnum

    -- 检测是否在 quickfix 窗口中
    if vim.bo[bufnr].filetype == 'qf' then
        local qf_idx = vim.fn.line '.'
        local qf_items = vim.fn.getqflist()
        if qf_idx < 1 or qf_idx > #qf_items then return end
        local item = qf_items[qf_idx]
        bufnr = vim.fn.bufnr(item.filename)
        if bufnr == -1 then
            bufnr = vim.fn.bufadd(item.filename)
            vim.fn.bufload(bufnr)
        end
        lnum = item.lnum
    else
        lnum = vim.api.nvim_win_get_cursor(0)[1]
    end

    -- 读取当前行
    local lines = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, false)
    local line = lines[1]
    if not line then return end

    local parsed = M.parse_line(line)
    if not parsed then
        vim.notify('[GTD] 当前行不是 TODO/DONE 任务', vim.log.levels.WARN)
        return
    end

    -- 切换状态
    if parsed.status == 'TODO' then
        parsed.status = 'DONE'
        parsed.closed = os.date '%Y-%m-%d %H:%M:%S'
    else
        parsed.status = 'TODO'
        parsed.closed = nil
    end

    local new_line = M.build_line(parsed)
    vim.api.nvim_buf_set_lines(bufnr, lnum - 1, lnum, false, { new_line })

    -- 保存文件
    if vim.bo[bufnr].modified then vim.api.nvim_buf_call(bufnr, function() vim.cmd 'write' end) end

    -- 刷新 quickfix（如果之前有加载过）
    if #vim.fn.getqflist() > 0 then M.set_todos_to_quickfix() end
end

-- ============================================================
-- 入口: setup(opts)
--   opts.todo_dir - 任务文件所在目录，默认为 nil，则关闭功能
--   opts.todo_file - 任务文件名，默认 todo.md
--   opts.toggle_key - 切换快捷键，默认 <leader>tt，nil 表示不绑定
-- ============================================================
function M.setup(opts)
    M.config = vim.tbl_deep_extend('force', M.config, opts or {})

    if M.config.todo_dir == nil then
        vim.notify('todo_dir is nil', vim.log.levels.WARN)
        return
    end

    -- 展开路径中的 ~
    M.config.todo_dir = vim.fn.expand(M.config.todo_dir)

    vim.api.nvim_create_user_command('GTDList', M.show_todos, {})
    vim.api.nvim_create_user_command('GTDToggle', M.toggle_status, {})

    vim.keymap.set('n', M.config.mappings.show_todos, M.show_todos, { desc = 'Show Todos' })
    vim.keymap.set('n', M.config.mappings.toggle_status, M.toggle_status, { desc = 'Toggle Status' })
end

return M
