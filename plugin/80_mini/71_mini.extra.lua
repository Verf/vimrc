-- mini.extra
Config.now(function() require('mini.extra').setup {} end)

vim.keymap.set('n', '<leader>h', function()
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
                vim.api.nvim_set_current_dir(full_path)
                vim.notify('cd ' .. full_path, vim.log.levels.INFO)
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
vim.keymap.set(
    'n',
    '<leader>nf',
    function() MiniPick.builtin.files({}, { source = { cwd = vim.fn.expand(vim.env.NOTE_TAKING_DIR) } }) end,
    { desc = 'Find Notes' }
)
