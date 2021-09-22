local actions = require'lir.actions'
-- local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'

require'lir'.setup {
    show_hidden_files = false,
    devicons_enable = true,
    mappings = {
        ['<CR>']  = actions.edit,
        ['<C-s>'] = actions.split,
        ['<C-v>'] = actions.vsplit,
        ['<C-t>'] = actions.tabedit,

        ['-']  = actions.up,
        ['q']     = actions.quit,

        ['K']     = actions.mkdir,
        ['N']     = actions.newfile,
        ['r']     = actions.rename,
        ['@']     = actions.cd,
        ['Y']     = actions.yank_path,
        ['.']     = actions.toggle_show_hidden,
        ['d']     = actions.delete,

        ['c']     = clipboard_actions.copy,
        ['x']     = clipboard_actions.cut,
        ['p']     = clipboard_actions.paste,
    },
    float = {
        winblend = 0,
    },
    hide_cursor = true,
}

-- custom folder icon
require'nvim-web-devicons'.set_icon({
    lir_folder_icon = {
        icon = "",
        color = "#7ebae4",
        name = "LirFolderNode"
    }
})
