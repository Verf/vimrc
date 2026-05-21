vim.pack.add { 'https://github.com/folke/which-key.nvim' }
local wk = require 'which-key'
wk.setup {
    preset = 'modern',
    delay = 250,
    icons = { mappings = false },
    triggers = { { '<auto>', mode = 'nso' } },
}
wk.add {
    { 'gr', group = '+Lsp' },
    { '<leader>g', group = '+Git' },
    { '<leader>gf', group = '+Find' },
    { '<leader>t', group = '+Tab/Term' },
    { '<leader>S', group = '+Session' },
    { '<leader>w', group = '+Window', expand = function() return require('which-key.extras').expand.win() end },
}
