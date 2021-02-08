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
