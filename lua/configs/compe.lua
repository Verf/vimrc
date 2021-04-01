local map = require('utils').map

require'compe'.setup{
    enabled = true,
    debug = false,
    autocomplete = true,
    min_length = 1,
    preselect = 'enable',
    source = {
        path      = true,
        calc      = true,
        buffer    = true,
        nvim_lsp  = true,
        nvim_lua  = true,
        vsnip     = true
    }
}

map('i', '<Tab>', [[vsnip#available(1) ? "<Plug>(vsnip-expand-or-jump)" : pumvisible() ? "\<C-n>" : "<Tab>"]], {noremap=false, expr=true})
map('i', '<S-Tab>', [[vsnip#available(1) ? "<Plug>(vsnip-jump-prev)" : pumvisible() ? "\<C-p>" : "<S-Tab>"]], {noremap=false, expr=true})
