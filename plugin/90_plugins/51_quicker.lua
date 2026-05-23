vim.pack.add { 'https://github.com/stevearc/quicker.nvim' }

Config.later(function()
    require('quicker').setup {
        keys = {
            {
                '>',
                function() require('quicker').expand { before = 2, after = 2, add_to_existing = true } end,
                desc = 'Expand quickfix context',
            },
            {
                '<',
                function() require('quicker').collapse() end,
                desc = 'Collapse quickfix context',
            },
        },
    }
end)

vim.keymap.set('n', '<leader>c', function() require('quicker').toggle() end, { desc = 'Toggle quickfix' })
