Config.now(function()
    require('mini.completion').setup {
        lsp_completion = {
            source_func = 'omnifunc',
            auto_setup = false,
        },
        fallback_action = '<C-n>',
    }
end)
