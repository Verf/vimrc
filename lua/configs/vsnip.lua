local map = require('utils').map

map('i', '<Tab>', [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']], {noremap=false, expr=true})
map('s', '<Tab>', [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']], {noremap=false, expr=true})
map('i', '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], {noremap=false, expr=true})
map('s', '<S-Tab>', [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], {noremap=false, expr=true})