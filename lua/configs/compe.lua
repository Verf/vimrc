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

map('i', '<CR>',    [[pumvisible() ? "compe#confirm(lexima#expand("<LT>CR>", "i"))" : "<CR>"]], {noremap=false, expr=true})
map('i', '<Tab>',   [[vsnip#available(1) ? "<Plug>(vsnip-expand)" : pumvisible() ? "\<C-n>" : "<Tab>"]], {noremap=false, expr=true})
map('s', '<Tab>',   [[vsnip#available(1) ? "<Plug>(vsnip-expand)" : pumvisible() ? "\<C-n>" : "<Tab>"]], {noremap=false, expr=true})
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "<S-Tab>"]], {noremap=false, expr=true})
map('s', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "<S-Tab>"]], {noremap=false, expr=true})
map('i', '<C-d>', [[<Plug>(vsnip-jump-next)]], {noremap=false})
map('s', '<C-d>', [[<Plug>(vsnip-jump-next)]], {noremap=false})
map('i', '<C-u>', [[<Plug>(vsnip-jump-prev)]], {noremap=false})
map('s', '<C-u>', [[<Plug>(vsnip-jump-prev)]], {noremap=false})
