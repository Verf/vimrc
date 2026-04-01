return {
    'stevearc/conform.nvim',

    event = { 'BufWritePre', 'BufReadPre' },
    opts = {
        default_format_opts = { lsp_format = 'fallback' },
        format_after_save = { lsp_format = 'fallback' },
        formatters_by_ft = {
            python = { 'ruff_format', 'ruff_organize_imports' },
            lua = { 'stylua' },
            json = { 'biome' },
            nu = { 'nufmt' },
            toml = { 'taplo' },
            yaml = { 'yamlfmt' },
        },
    },
}
