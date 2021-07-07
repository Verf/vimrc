local actions = require'lir.actions'
local clipboard_actions = require'lir.clipboard.actions'

require'lir'.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
        ['<CR>']  = actions.edit,
        ['<C-s>'] = actions.split,
        ['<C-v>'] = actions.vsplit,
        ['<C-t>'] = actions.tabedit,

        ['-']     = actions.up,
        ['q']     = actions.quit,

        ['D']     = actions.mkdir,
        ['F']     = actions.newfile,
        ['R']     = actions.rename,
        ['@']     = actions.cd,
        ['y']     = actions.yank_path,
        ['.']     = actions.toggle_show_hidden,

        ['c']     = clipboard_actions.copy,
        ['x']     = clipboard_actions.cut,
        ['v']     = clipboard_actions.paste,
  },
  float = {
    size_percentage = 0.6,
    winblend = 15,
    border = true,
    borderchars = {"╭" , "─" , "╮" , "│" , "╯" , "─" , "╰", "│"},
    shadow = false,
  },
  hide_cursor = true,
}
