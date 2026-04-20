return {
    'stevearc/conform.nvim',
    keys = {
        { '<leader>m', function() require('conform').format { async = true } end, mode = 'n', desc = 'Format' },
    },
    opts = {
        default_format_opts = { lsp_format = 'fallback' },
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
