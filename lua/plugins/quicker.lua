return {
    'stevearc/quicker.nvim',
    ft = 'qf',
    keys = {
        { '<leader>c', function() require('quicker').toggle() end, mode = 'n', desc = 'Toggle quickfix' },
    },
    config = function()
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
    end,
}
