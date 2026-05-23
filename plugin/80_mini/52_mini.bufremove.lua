-- mini.bufremove
Config.later(function()
    require('mini.bufremove').setup {}
end)

vim.keymap.set(
    { 'n', 'x' },
    '<leader>q',
    function() require('mini.bufremove').delete(0, true) end,
    { desc = 'Close Buffer' }
)
