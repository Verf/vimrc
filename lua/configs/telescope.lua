local map = require('utils').map
local actions = require('telescope.actions')

require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = actions.close
            },
        },
    },
    file_previewer = nil,
}

require('telescope').load_extension('fzy_native')

map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>ft', '<cmd>Telescope tags<CR>')
map('n', '<leader>bb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fh', '<cmd>Telescope oldfiles<CR>')
