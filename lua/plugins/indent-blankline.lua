return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPost',
    opts = {
        indent = { char = '┊' },
        scope = { char = '│', show_start = false, show_end = false },
        exclude = {
            filetypes = {
                'help',
                'alpha',
                'dashboard',
                'neo-tree',
                'Trouble',
                'trouble',
                'lazy',
                'mason',
                'notify',
                'toggleterm',
                'NvimTree',
            },
        },
    },
}
