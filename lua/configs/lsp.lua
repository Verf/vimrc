-- disable diagnostic virtual text
vim.diagnostic.config {
    virtual_text = false,
}
-- capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
    require('lspconfig')[name].setup {
        capabilities = capabilities,
    }
end

require('lspconfig').jedi_language_server.setup {
    capabilities = capabilities,
}
