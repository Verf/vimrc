<<<<<<< HEAD
require'telescope'.load_extension('project')
=======
local actions = require('telescope.actions')
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-c>"] = false,
            },
            n = {
                ["<ESC>"] = actions.close,
                ["j"] = false,
                ["k"] = false,
            }
        }
    }
}
>>>>>>> 517958f79bef9ce477868fc014ee169b263c95d9
