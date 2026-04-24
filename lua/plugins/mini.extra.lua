return {
    'nvim-mini/mini.extra',
    version = '*',
    dependencies = { 'nvim-mini/mini.pick' },
    lazy = false,
    keys = {
        { '<leader>h', function() MiniExtra.pickers.oldfiles() end, mode = 'n', desc = 'Oldfiles' },
        {
            '<leader>d',
            function() MiniExtra.pickers.diagnostic { scope = 'current' } end,
            mode = 'n',
            desc = 'Diagnostics',
        },
        {
            '<leader>s',
            function() MiniExtra.pickers.lsp { scope = 'document_symbol' } end,
            mode = 'n',
            desc = 'Symbols',
        },
        -- git
        {
            '<leader>gb',
            function() MiniExtra.pickers.git_branches {  scope = 'local' } end,
            mode = 'n',
            desc = 'Find Git Branches',
        },
        {
            '<leader>gfs',
            function() MiniExtra.pickers.git_hunks { path = '%', scope = 'staged' } end,
            mode = 'n',
            desc = 'Find Staged',
        },
        {
            '<leader>gfS',
            function() MiniExtra.pickers.git_hunks { scope = 'staged' } end,
            mode = 'n',
            desc = 'Find All Staged',
        },
        {
            '<leader>gfu',
            function() MiniExtra.pickers.git_hunks { path = '%', scope = 'unstaged' } end,
            mode = 'n',
            desc = 'Find Unstaged',
        },
        {
            '<leader>gfU',
            function() MiniExtra.pickers.git_hunks { scope = 'unstaged' } end,
            mode = 'n',
            desc = 'Find All Unstaged',
        },
        -- lsp
        { 'grr', function() MiniExtra.pickers.lsp { scope = 'references' } end, mode = 'n', desc = 'Goto references' },
        {
            'gri',
            function() MiniExtra.pickers.lsp { scope = 'implementation' } end,
            mode = 'n',
            desc = 'Goto implementation',
        },
        {
            'grt',
            function() MiniExtra.pickers.lsp { scope = 'type_definition' } end,
            mode = 'n',
            desc = 'Goto type_definition',
        },
    },
    opts = {},
}
