return {
    'nvim-mini/mini.extra',
    version = '*',
    lazy = false,
    keys = {
        { '<leader>h', function() MiniExtra.pickers.oldfiles() end, mode = 'n', desc = 'Oldfiles' },
        { '<leader>d', function() MiniExtra.pickers.diagnostic() end, mode = 'n', desc = 'Diagnostics' },
        { '<leader>e', function() MiniExtra.pickers.explorer() end, mode = 'n', desc = 'Explorer' },
        { '<leader>s', function() MiniExtra.pickers.lsp { scope = 'workspace_symbol' } end, mode = 'n', desc = 'Symbols' },
        { '<leader>gfs', function() MiniExtra.pickers.git_hunks { path = '%', scope = 'staged' } end, mode = 'n', desc = 'Find Staged' },
        { '<leader>gfS', function() MiniExtra.pickers.git_hunks { scope = 'staged' } end, mode = 'n', desc = 'Find All Staged' },
        { '<leader>gfu', function() MiniExtra.pickers.git_hunks { path = '%', scope = 'unstaged' } end, mode = 'n', desc = 'Find Unstaged' },
        { '<leader>gfU', function() MiniExtra.pickers.git_hunks { scope = 'unstaged' } end, mode = 'n', desc = 'Find All Unstaged' },
    },
    opts = {},
}
