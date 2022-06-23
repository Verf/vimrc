local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(client, _)
    -- disable default formatting
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
end

require('ufo').setup()
-- python setup
require('lspconfig').pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- lua setup
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    cmd = { 'lua-language-server' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- vue setup
require('lspconfig').vuels.setup {
    cmd = { 'vls.cmd' },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- ts setup
require('lspconfig').tsserver.setup {
    cmd = { 'typescript-language-server.cmd', '--stdio' },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- bash setup
require('lspconfig').bashls.setup {
    cmd = { 'bash-language-server.cmd', 'start' },
    filetypes = { 'sh', 'sql' },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- go setup
require('lspconfig').gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('lspkind').init()

require('lsp_signature').setup {
    bind = true,
    hint_prefix = ' ',
    handler_opts = {
        border = 'single',
    },
    decorator = { '*', '*' },
}
