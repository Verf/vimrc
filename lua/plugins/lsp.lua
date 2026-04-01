return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local kset = vim.keymap.set
        vim.lsp.enable { 'ty', 'ruff', 'biome', 'rust_analyzer', 'gopls', 'zls', 'nushell' }

        kset({ 'n', 'x' }, '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = 'Rename' })
        kset({ 'n', 'x' }, '<leader>ra', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = 'Code Action' })
        kset({ 'n', 'x' }, '<leader>rh', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Hover Doc' })

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client then client.server_capabilities.semanticTokensProvider = nil end
            end,
        })
    end,
}
