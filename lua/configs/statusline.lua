require'nvim-gps'.setup()

local gps = require("nvim-gps")

require'lualine'.setup{
    options = {
        theme = 'onedark'
    },
    sections = {
        lualine_c = {
            'filename',
            { gps.get_location, condition = gps.is_available },
        }
    }
}
