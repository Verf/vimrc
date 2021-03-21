require('lspsaga').init_lsp_saga()
require('lspkind').init()

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Set autocommands conditional on server_capabilities
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
end
-- loop to setup
local servers = { "pyright" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup { on_attach = on_attach }
end