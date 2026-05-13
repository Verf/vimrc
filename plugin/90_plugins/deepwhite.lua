vim.pack.add { { src = 'https://github.com/Verf/deepwhite.nvim', version = 'dev' } }

require('deepwhite').setup { low_blue_light = true }
vim.cmd.colorscheme 'deepwhite'
