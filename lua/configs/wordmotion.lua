local g = vim.g
local map = require('utils').map

g.wordmotion_nomap = 1

map('n', 'w', '<Plug>WordMotion_w', {noremap=false})
map('n', 'W', '<Plug>WordMotion_W', {noremap=false})
map('n', 'b', '<Plug>WordMotion_b', {noremap=false})
map('n', 'B', '<Plug>WordMotion_B', {noremap=false})
map('n', 'd', '<Plug>WordMotion_e', {noremap=false})
map('n', 'D', '<Plug>WordMotion_d', {noremap=false})
map('o', 'aW', '<Plug>WordMotion_aW', {noremap=false})
map('o', 'iW', '<Plug>WordMotion_iW', {noremap=false})
