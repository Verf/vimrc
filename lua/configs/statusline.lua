require'nvim-gps'.setup()

local gps = require("nvim-gps")

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
            {
                gps.get_location,
                condition = gps.is_available,
            },
        }
    }
}
