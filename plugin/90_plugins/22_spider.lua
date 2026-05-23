vim.pack.add { 'https://github.com/chrisgrieser/nvim-spider' }

Config.now(function()
    vim.keymap.set({ 'n', 'o', 'x' }, 'w', function() require('spider').motion 'w' end)
    vim.keymap.set({ 'n', 'o', 'x' }, 'd', function() require('spider').motion 'e' end)
    vim.keymap.set({ 'n', 'o', 'x' }, 'b', function() require('spider').motion 'b' end)
end)
