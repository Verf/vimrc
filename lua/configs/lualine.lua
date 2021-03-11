require('lualine').status{
    options = {
        theme = 'onedark',
        component_separators = nil,
        icons_enabled = true,
    },
    sections = {
        lualine_c = { {'filename', file_status = true} },
    },
}
