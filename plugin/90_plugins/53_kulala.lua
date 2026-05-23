vim.pack.add { 'https://github.com/mistweaverco/kulala.nvim' }

Config.later(function()
    require('kulala').setup {
        global_keymaps = false,
        global_keymaps_prefix = '<leader>r',
        kulala_keymaps_prefix = '',
    }
end)

vim.keymap.set({ 'n', 'v' }, '<leader>rs', function() require('kulala').run() end, { desc = 'Send request' })
vim.keymap.set({ 'n', 'v' }, '<leader>ra', function() require('kulala').run_all() end, { desc = 'Send all request' })
vim.keymap.set({ 'n', 'v' }, '<leader>rr', function() require('kulala').replay() end, { desc = 'Replay last request' })
