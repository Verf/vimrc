require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    allow_prefix_unmatch = false;

    source = {
        path = true;
        buffer = true;
        calc = true;
        vsnip = false;
        nvim_lsp = true;
        nvim_lua = true;
        spell = false;
        tags = true;
        snippets_nvim = false;
        ultisnips = true;
    };
}
