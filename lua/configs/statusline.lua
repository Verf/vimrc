require('lualine').setup {
    options = {
        theme = 'auto',
    },
    sections = {
        lualine_b = {
            'branch',
        },
        lualine_c = {
            'filename',
            'diff',
        },
    },
}
