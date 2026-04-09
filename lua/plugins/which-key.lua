return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'modern',
        delay = 250,
        icons = { mappings = false },
        triggers = { { '<auto>', mode = 'nso' } },
    },
    config = function(_, opts)
        local wk = require 'which-key'
        wk.setup(opts)
        wk.add {
            { 'gr', group = '+Lsp' },
            { '<leader>f', group = '+Find' },
            { '<leader>g', group = '+Git' },
            { '<leader>t', group = '+Tab' },
            { '<leader>s', group = '+Surround/Swap' },
            { '<leader>w', group = '+Window' },
        }
    end,
}
