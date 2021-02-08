local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
<<<<<<< HEAD
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
=======
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
>>>>>>> 517958f79bef9ce477868fc014ee169b263c95d9


    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
        augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

-- loop to setup
local servers = { "pyright", }
for _, lsp in ipairs(servers) do
<<<<<<< HEAD
    nvim_lsp[lsp].setup { capabilities = capabilities, on_attach = on_attach }
=======
    nvim_lsp[lsp].setup { on_attach = on_attach }
>>>>>>> 517958f79bef9ce477868fc014ee169b263c95d9
end

-- lsp ui
require'lspsaga'.init_lsp_saga()
