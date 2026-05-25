vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

Config.later(
    function()
        require('conform').setup {
            default_format_opts = { lsp_format = 'fallback' },
            formatters_by_ft = {
                python = { 'ruff_format', 'ruff_organize_imports' },
                lua = { 'stylua' },
                nu = { 'nufmt' },
                toml = { 'taplo' },
                yaml = { 'yamlfmt' },
                json = { 'oxfmt' },
                javascript = { 'oxfmt' },
                typescript = { 'oxfmt' },
                vue = { 'oxfmt' },
            },
        }
    end
)

vim.keymap.set('n', '<leader>m', function() require('conform').format { async = true } end, { desc = 'Format' })
