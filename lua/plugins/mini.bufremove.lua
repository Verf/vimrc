return {
    'nvim-mini/mini.bufremove',
    keys = {
        {
            '<leader>x',
            function() require('mini.bufremove').delete(0, true) end,
            mode = { 'n', 'x' },
            desc = 'Close Buffer',
        },
    },
    opts = {},
}
