return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        preset = 'modern',
        delay = 250,
        icons = { mappings = false },
        triggers = { { '<auto>', mode = 'nso' } },
        sort = { 'mod', 'alphanum' },
    },
    config = function(_, opts)
        local wk = require 'which-key'
        wk.setup(opts)
        wk.add {
            { 'gr', group = '+Lsp' },
            { '<leader>t', group = '+Tab/Term' },
            { '<leader>S', group = '+Session' },
            { '<leader>w', group = '+Window', expand = function() return require('which-key.extras').expand.win() end },
        }
    end,
}
