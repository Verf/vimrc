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
-- local sumneko_root_path = [[C:\Programes\lua-language-server]]
-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
-- require'lspconfig'.sumneko_lua.setup {
--     cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--     settings = {
--         Lua = {
--             runtime = {
--                 version = 'LuaJIT',
--                 path = vim.split(package.path, ';'),
--             },
--             diagnostics = {
--                 globals = {'vim'},
--             },
--             workspace = {
--                 library = {
--                     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--                     [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--                 },
--             },
--         },
--     },
--     on_attach = on_attach,
-- }


-- vue setup
require'lspconfig'.vuels.setup{
    cmd = { "vls.cmd" },
    capabilities = capabilities
}


-- ts setup
require'lspconfig'.tsserver.setup{
    cmd = { "typescript-language-server.cmd", "--stdio" },
    capabilities = capabilities
}

require('lspkind').init()
