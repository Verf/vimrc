-- mini.git
require('mini.git').setup {}

vim.keymap.set({ 'n', 'x' }, '<leader>gs', function() require('mini.git').show_at_cursor() end, { desc = 'Show' })
