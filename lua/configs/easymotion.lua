local g = vim.g
local map = require('utils').map

g.EasyMotion_smartcase = 1
g.EasyMotion_do_mapping = 0

map('n', 's', '<Plug>(easymotion-s2)', {noremap=false})
map('n', '/', '<Plug>(easymotion-sn)', {noremap=false})
map('o', '/', '<Plug>(easymotion-tn)', {noremap=false})
map('n', 'gl', '<Plug>(easymotion-overwin-line)', {noremap=false})
map('n', 'gw', '<Plug>(easymotion-bd-w)', {noremap=false})
map('n', 'ge', '<Plug>(easymotion-bd-e)', {noremap=false})
map('n', 'gf', '<Plug>(easymotion-lineforward)', {noremap=false})
map('n', 'gb', '<Plug>(easymotion-linebackward)', {noremap=false})
map('n', 'gn', '<Plug>(easymotion-j)', {noremap=false})
map('n', 'gi', '<Plug>(easymotion-k)', {noremap=false})