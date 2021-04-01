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

map('i', '<CR>',    [[pumvisible() ? "compe#confirm(lexima#expand("<LT>CR>", "i"))" : "<CR>"]])
map('i', '<Tab>',   [[vsnip#available(1) ? "<Plug>(vsnip-expand)" : pumvisible() ? "\<C-n>" : vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"]], {noremap=false, expr=true})
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"]], {noremap=false, expr=true})
