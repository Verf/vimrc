local g = vim.g
local map = require('utils').map

g.vista_stay_on_open = 0
map('', '<F3>', ':Vista!!<CR>')