-- quicker.nvim 的自实现替代，见 lua/plugins/quickfix.lua
Config.later(function()
    require('plugins.quickfix').setup {
        keys = {
            {
                '>',
                function() require('plugins.quickfix').expand { before = 2, after = 2, add_to_existing = true } end,
                desc = 'Expand quickfix context',
            },
            {
                '<',
                function() require('plugins.quickfix').collapse() end,
                desc = 'Collapse quickfix context',
            },
        },
    }
end)

vim.keymap.set('n', '<leader>c', function() require('plugins.quickfix').toggle() end, { desc = 'Toggle quickfix' })
