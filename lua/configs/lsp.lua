local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

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
local system_name
if vim.fn.has("mac") == 1 then
    system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko")
end

local lua_lsp_path = os.getenv('LUA_LANGUAGE_SERVER')
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
    cmd = {lua_lsp_path .. '/bin/' .. system_name .. '/lua-language-server'},
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
    capabilities = capabilities
}


-- ts setup
require'lspconfig'.tsserver.setup{
    cmd = { 'typescript-language-server.cmd', '--stdio' },
    capabilities = capabilities
}

require('lspkind').init()
