-- mini.bufremove
require('mini.bufremove').setup {}

vim.keymap.set(
    { 'n', 'x' },
    '<leader>q',
    function() require('mini.bufremove').delete(0, true) end,
    { desc = 'Close Buffer' }
)
