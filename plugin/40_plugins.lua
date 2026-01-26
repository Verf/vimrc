local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local now_if_args = _G.Config.now_if_args

later(function()
    add 'chrisgrieser/nvim-spider'

    vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>")
    vim.keymap.set({ 'n', 'o', 'x' }, 'd', "<cmd>lua require('spider').motion('e')<CR>")
    vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>")
end)

later(function()
    add 'neovim/nvim-lspconfig'

    vim.lsp.enable { 'ty', 'ruff', 'biome' }
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

        formatters_by_ft = {
            lua = { 'stylua' },
            json = { 'biome' },
            javascript = { 'dprint' },
            typescript = { 'dprint' },
            vue = { 'dprint' },
        },
    }
end)
