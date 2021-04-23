local map = require('utils').map

require'fuzzy'.setup {
  width = 60,
  height = 40,
  blacklist = {
    "vendor",
    ".git"
  },
  sorter = require'fuzzy.lib.sorter'.fzy,
  prompt = '> ',
}

map('n', '<leader>ff', ':Fuzzy find_files<CR>')
map('n', '<leader>bb', ':Fuzzy buffers<CR>')
map('n', '<leader>fh', ':Fuzzy recent_files<CR>')
map('n', '<leader>fg', ':Fuzzy grep<CR>')
