require'lualine'.setup{
    options = {
        theme = 'solarized'
    },
    sections = {
        lualine_b = {
            'branch',
        },
        lualine_c = {
            'filename',
            'diff',
        }
    }
}
