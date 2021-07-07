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

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead term=underline cterm=underline gui=underline
        hi LspReferenceText term=underline cterm=underline gui=underline
        hi LspReferenceWrite term=underline cterm=underline gui=underline
        augroup lsp_document_highlight
        au!
        au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
            ]], false)
    end

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
    on_attach = on_attach
}

-- lua setup
local sumneko_root_path = [[C:\Programes\lua-language-server]]
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
    on_attach = on_attach,
}


require('lspsaga').init_lsp_saga{
    finder_action_keys = {
        open = '<CR>',
        vsplit = 'v',
        split = 's',
        quit = '<ESC>',
        scroll_up = '<C-u>',
        scroll_down = '<C-d>'
    }
}

require('lspkind').init()
