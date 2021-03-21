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
        vsnips    = true
    }
}