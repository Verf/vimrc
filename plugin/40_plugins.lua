local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local now_if_args = _G.Config.now_if_args

later(function() vim.lsp.enable { 'ty', 'ruff' } end)

now(function()
    add 'ibhagwan/fzf-lua'

    require('fzf-lua').setup { defaults = { git_icons = false } }

    vim.keymap.set('n', '<leader>f', [[<Cmd>lua require"fzf-lua".files()<CR>]], {})
    vim.keymap.set('n', '<leader>g', [[<Cmd>lua require"fzf-lua".live_grep()<CR>]], {})
end)

later(function()
    add 'stevearc/conform.nvim'

    require('conform').setup {
        default_format_opts = {
            lsp_format = 'fallback', -- 配置lsp的格式化器为默认项
        },
        format_on_save = {
            timeout_ms = 500,
        },

        formatters_by_ft = { lua = { 'stylua' } },
    }
end)
