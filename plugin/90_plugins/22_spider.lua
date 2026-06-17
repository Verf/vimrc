-- nvim-spider 的自实现替代，见 lua/plugins/subword.lua
Config.now(function()
    vim.keymap.set(
        { 'n', 'o', 'x' },
        'w',
        function() require('plugins.subword').motion 'w' end,
        { desc = 'camelCase/subword forward' }
    )
    vim.keymap.set(
        { 'n', 'o', 'x' },
        'd',
        function() require('plugins.subword').motion 'e' end,
        { desc = 'camelCase/subword end' }
    )
    vim.keymap.set(
        { 'n', 'o', 'x' },
        'b',
        function() require('plugins.subword').motion 'b' end,
        { desc = 'camelCase/subword back' }
    )
end)
