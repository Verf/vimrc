require'snippets'.use_suggested_mappings()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;

require'snippets'.snippets = {
    python = {
        ["utf"] = [[
        # -*- coding: utf-8 -*-
        $0
        ]]
    }
}
