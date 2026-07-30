-- mini.extra
Config.now(function() require('mini.extra').setup {} end)

vim.keymap.set('n', '<leader>o', function()
    MiniExtra.pickers.visit_paths {
        filter = function(data) return vim.fn.isdirectory(data.path) == 0 end,
        cwd = '', -- 默认限制在cwd范围，设置cwd = ''可查询全局
    }
end, { desc = 'Oldfiles' })
vim.keymap.set('n', '<leader>z', function()
    MiniExtra.pickers.visit_paths({
        filter = function(data) return vim.fn.isdirectory(data.path) == 1 end,
        cwd = '', -- 默认限制在cwd范围，设置cwd = ''可查询全局
    }, {
        source = {
            name = 'Visits',
            choose = function(item)
                if item == nil then return end
                local full_path = vim.fn.fnamemodify(item, ':p')
                vim.schedule(function()
                    -- 复用 _files_picker：git 仓库走 git ls-files，否则 fallback rg
                    if _G._files_picker then
                        _G._files_picker(full_path)
                    else
                        -- 防御：如果 70_mini.pick.lua 没加载（极端情况），回退 rg
                        if vim.fn.executable 'rg' == 1 then
                            MiniPick.builtin.cli({ command = { 'rg', '--files', '-j', '1', '--color=never' } }, {
                                source = {
                                    name = 'Files (rg)',
                                    cwd = full_path,
                                    show = function(buf_id, items, query)
                                        MiniPick.default_show(buf_id, items, query, { show_icons = true })
                                    end,
                                },
                            })
                        else
                            MiniPick.builtin.files({}, { source = { cwd = full_path } })
                        end
                    end
                end)
            end,
        },
    })
end, { desc = 'Visit Directories' })
vim.keymap.set(
    'n',
    '<leader>d',
    function() MiniExtra.pickers.diagnostic { scope = 'current' } end,
    { desc = 'Diagnostics' }
)

vim.keymap.set(
    'n',
    '<leader>s',
    function() MiniExtra.pickers.lsp { scope = 'document_symbol' } end,
    { desc = 'Symbols' }
)
vim.keymap.set(
    'n',
    '<leader>gb',
    function() MiniExtra.pickers.git_branches { scope = 'local' } end,
    { desc = 'Find Git Branches' }
)
vim.keymap.set(
    'n',
    '<leader>gfs',
    function() MiniExtra.pickers.git_hunks { path = '%', scope = 'staged' } end,
    { desc = 'Find Staged' }
)
vim.keymap.set(
    'n',
    '<leader>gfS',
    function() MiniExtra.pickers.git_hunks { scope = 'staged' } end,
    { desc = 'Find All Staged' }
)
vim.keymap.set(
    'n',
    '<leader>gfu',
    function() MiniExtra.pickers.git_hunks { path = '%', scope = 'unstaged' } end,
    { desc = 'Find Unstaged' }
)
vim.keymap.set(
    'n',
    '<leader>gfU',
    function() MiniExtra.pickers.git_hunks { scope = 'unstaged' } end,
    { desc = 'Find All Unstaged' }
)
vim.keymap.set('n', 'grr', function() MiniExtra.pickers.lsp { scope = 'references' } end, { desc = 'Goto references' })
vim.keymap.set(
    'n',
    'gri',
    function() MiniExtra.pickers.lsp { scope = 'implementation' } end,
    { desc = 'Goto implementation' }
)
vim.keymap.set(
    'n',
    'grt',
    function() MiniExtra.pickers.lsp { scope = 'type_definition' } end,
    { desc = 'Goto type_definition' }
)
-- Windows 上 Neovim 的 ~ 展开到 MSYS2 $HOME，而非 %USERPROFILE%。
local function expand_dir(path)
    if vim.fn.has 'win32' == 1 and path:sub(1, 1) == '~' then
        local win_home = os.getenv 'USERPROFILE'
        if win_home then return win_home:gsub('\\', '/') .. path:sub(2) end
    end
    return vim.fn.expand(path)
end

vim.keymap.set('n', '<leader>nf', function()
    local dir = vim.env.NOTE_TAKING_DIR
    if not dir or dir == '' then
        vim.notify('NOTE_TAKING_DIR is not set', vim.log.levels.WARN)
        return
    end
    dir = expand_dir(dir)
    if vim.fn.isdirectory(dir) == 0 then
        vim.notify('NOTE_TAKING_DIR does not exist: ' .. dir, vim.log.levels.WARN)
        return
    end
    MiniPick.builtin.files({}, { source = { cwd = dir } })
end, { desc = 'Find Notes' })
