-- [[ LSP 服务器配置 ]]

-- Python: ruff（lint + 组织 imports）
vim.lsp.config('ruff', {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
})

-- Python: ty（类型检查）
vim.lsp.config('ty', {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', '.git' },
})

-- Nushell
vim.lsp.config('nushell', {
    cmd = { 'nu', '--lsp' },
    filetypes = { 'nu' },
    root_markers = { '.git' },
})

-- Lua: lua_ls（Lua Language Server）
vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

-- Vue2: vls（Vetur Language Server，仅兼容 Node ≤16）
vim.lsp.config('vls', {
    cmd = { 'vls' },
    filetypes = { 'vue' },
    root_markers = { 'package.json', 'vue.config.js' },
})

-- 启用所有服务器（按文件类型自动启动）
vim.lsp.enable { 'lua_ls', 'ruff', 'ty', 'nushell', 'vls' }

-- LSP 附加回调
vim.api.nvim_create_autocmd('LspAttach', {
    group = _G.MyGroup,
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end

        -- 禁用 semantic tokens，避免与 tree-sitter 高亮冲突
        client.server_capabilities.semanticTokensProvider = nil

        -- 设置 omnifunc 为 mini.completion 的 LSP 补全函数
        vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

        -- Buffer-local keymaps（仅在有 LSP 时生效）
        local buf = args.buf
        vim.keymap.set('n', 'gk', vim.lsp.buf.hover, { buffer = buf, desc = 'Show Doc' })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buf, desc = 'Goto Definition' })
    end,
    desc = 'LSP attach: disable semantic tokens, bind keymaps',
})
