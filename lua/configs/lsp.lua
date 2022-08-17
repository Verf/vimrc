local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    documentationFormat = { 'markdown', 'plaintext' },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        },
    },
}
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(client, _)
    -- disable default formatting
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
end

-- lua setup
require('lspconfig').sumneko_lua.setup {
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
    on_attach = on_attach,
    capabilities = capabilities,
}

-- mason
require('mason').setup {
    ui = {
        check_outdated_packages_on_open = false,
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
    if name ~= 'sumneko_lua' then
        require('lspconfig')[name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end
end

-- ui enhance
require('lsp_signature').setup {
    bind = true,
    hint_prefix = ' ',
    handler_opts = {
        border = 'single',
    },
    decorator = { '*', '*' },
}
