-- disable diagnostic virtual text
vim.diagnostic.config {
    virtual_text = false,
}
-- capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lua setup
require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = {
                    [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                    [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
    capabilities = capabilities,
}

-- mason
require('mason').setup {
    ui = {
        check_outdated_packages_on_open = true,
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
        keymaps = {
            install_package = 'r',
        },
    },
}
require('mason-lspconfig').setup()
local mason_lsp = require 'mason-lspconfig'
for _, name in pairs(mason_lsp.get_installed_servers()) do
    if name ~= 'sumneko_lua' and name ~= 'lua_ls' then
        require('lspconfig')[name].setup {
            capabilities = capabilities,
        }
    end
end
