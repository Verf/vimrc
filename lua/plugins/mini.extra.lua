return {
    'nvim-mini/mini.extra',
    version = '*',
    lazy = false,
    keys = {
        { '<leader>h', function() MiniExtra.pickers.oldfiles() end, mode = 'n', desc = 'Oldfiles' },
        { '<leader>d', function() MiniExtra.pickers.diagnostic() end, mode = 'n', desc = 'Diagnostics' },
        { '<leader>e', function() MiniExtra.pickers.explorer() end, mode = 'n', desc = 'Explorer' },
        { '<leader>s', function() MiniExtra.pickers.lsp { scope = 'workspace_symbol' } end, mode = 'n', desc = 'Symbols' },
    },
    opts = {},
}
