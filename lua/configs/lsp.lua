local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(client, bufnr)
    -- enable signature help
    require('lsp_signature').on_attach({
        bind = true,
        hint_prefix = ' ',
        handler_opts = {
            border = 'single'
        },
        decorator = {'*', '*'}
    })
end

-- python setup
require'lspconfig'.pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities
}

-- lua setup
local lua_lsp_path = os.getenv('LUA_LANGUAGE_SERVER')
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require'lspconfig'.sumneko_lua.setup {
    cmd = {lua_lsp_path .. '/bin/lua-language-server'},
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = {'vim'},
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
require'lspconfig'.vuels.setup{
    cmd = { 'vls.cmd' },
    capabilities = capabilities,
}

-- ts setup
require'lspconfig'.tsserver.setup{
    cmd = { 'typescript-language-server.cmd', '--stdio' },
    capabilities = capabilities,
}

-- bash setup
require'lspconfig'.bashls.setup{
    cmd = { "bash-language-server.cmd", "start" },
    filetypes = { "sh", "sql" },
}

require('lspkind').init()

