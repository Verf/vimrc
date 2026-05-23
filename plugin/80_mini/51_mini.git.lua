-- mini.git
Config.later(function()
    require('mini.git').setup {}
end)

vim.keymap.set({ 'n', 'x' }, '<leader>gs', function() require('mini.git').show_at_cursor() end, { desc = 'Show' })
