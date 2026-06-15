vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

Config.later(
    function()
        require('conform').setup {
            default_format_opts = { lsp_format = 'fallback' },
            formatters_by_ft = {
                python = { 'ruff_format', 'ruff_organize_imports' },
                lua = { 'stylua' },
                nu = { 'nufmt' },
                markdown = { 'gtd_format' },
                toml = { 'taplo' },
                yaml = { 'yamlfmt' },
                json = { 'oxfmt' },
                javascript = { 'oxfmt' },
                typescript = { 'oxfmt' },
                vue = { 'oxfmt' },
            },
            formatters = {
                gtd_format = {
                    format = function(self, ctx, lines, callback)
                        local ok, result = pcall(require('plugins.gtd').format_lines, lines)
                        if ok then
                            callback(nil, result)
                        else
                            callback(result, nil)
                        end
                    end,
                },
            },
        }
    end
)

vim.keymap.set('n', '<leader>m', function() require('conform').format { async = true } end, { desc = 'Format' })
