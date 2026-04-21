return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        vim.lsp.enable { 'ty', 'ruff', 'biome', 'rust_analyzer', 'gopls', 'zls', 'nushell' }

        vim.api.nvim_create_autocmd('LspAttach', {
            group = _G.my_group,
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client then client.server_capabilities.semanticTokensProvider = nil end
            end,
        })
    end,
}
