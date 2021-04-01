local g = vim.g
local map = require('utils').map

g.NERDCreateDefaultMappings = 0

map('n', 'gc', '<Plug>NERDCommenterToggle', {noremap=false})
