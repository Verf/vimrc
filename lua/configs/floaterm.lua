local g = vim.g
local map = require('utils').map

g.floaterm_weight      = 0.8
g.floaterm_height      = 0.8
g.floaterm_autoclose   = 1
g.floaterm_shell       = 'pwsh -nologo'
g.floaterm_rootmarkers =  {'.project', '.git', '.gitignore', 'pom.xml'}

map('', '<F1>', ':FloatermToggle<CR>')
map('t', '<C-o>', '<C-\\><C-n>')
map('t', '<C-`>', '<C-\\><C-n>:FloatermToggle<CR>')
map('t', '<C-t>', '<C-\\><C-n>:FloatermNew<CR>')
map('t', '<C-q>', '<C-\\><C-n>:FloatermKill<CR>')
map('t', '<C-n>', '<C-\\><C-n>:FloatermNext<CR>')
map('t', '<C-p>', '<C-\\><C-n>:FloatermPrev<CR>')