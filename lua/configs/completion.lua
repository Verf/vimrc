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
vim.api.nvim_set_keymap('i', '<CR>',    [[compe#confirm({ "keys": "\<Plug>delimitMateCR", "mode": "" })]], {noremap=false, silent=true, expr=true})
vim.api.nvim_set_keymap('i', '<Tab>',   [[vsnip#expandable() ? "<Plug>(vsnip-expand)" : pumvisible() ? "\<C-n>" : "<Tab>"]], {noremap=false, silent=true, expr=true})
vim.api.nvim_set_keymap('s', '<Tab>',   [[vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"]], {noremap=false, silent=true, expr=true})
vim.api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "<S-Tab>"]], {noremap=false, silent=true, expr=true})
vim.api.nvim_set_keymap('s', '<S-Tab>', [[vsnip#jumpable(1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"]], {noremap=false, silent=true, expr=true})
vim.api.nvim_set_keymap('i', '<C-d>', [[<Plug>(vsnip-jump-next)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('s', '<C-d>', [[<Plug>(vsnip-jump-next)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('i', '<C-u>', [[<Plug>(vsnip-jump-prev)]], {noremap=false, silent=true})
vim.api.nvim_set_keymap('s', '<C-u>', [[<Plug>(vsnip-jump-prev)]], {noremap=false, silent=true})
