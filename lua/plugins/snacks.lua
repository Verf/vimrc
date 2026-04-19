return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    keys = {
        { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
        { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
        { '<leader>b', function() Snacks.picker.buffers() end, desc = 'Buffers' },
        { '<leader>ff', function() Snacks.picker.files() end, desc = 'Find Files' },
        { '<leader>fh', function() Snacks.picker.recent() end, desc = 'History Files' },
        { '<leader>fd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
        { '<leader>fD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
        { '<leader>fu', function() Snacks.picker.undo() end, desc = 'Undo History' },
        { 'gw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
    },
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = true },
        input = { enabled = false },
        picker = {
            layout = {
                preset = 'ivy_split',
                layout = {
                    height = 0.25,
                },
            },
        },
        notifier = { enabled = false },
        quickfile = { enabled = true },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = true },
    },
    init = function()
        -- Lsp快捷键使用telescope，需要在LspAttach时绑定
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('MySnacksGroup', { clear = true }),
            callback = function(event)
                local buf = event.buf

                vim.keymap.set(
                    'n',
                    '<leader>fs',
                    function() Snacks.picker.lsp_symbols() end,
                    { buffer = buf, desc = 'LSP Symbols' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>fS',
                    function() Snacks.picker.lsp_workspace_symbols() end,
                    { buffer = buf, desc = 'LSP Workspace Symbols' }
                )
                vim.keymap.set(
                    'n',
                    'gd',
                    function() Snacks.picker.lsp_definitions() end,
                    { buffer = buf, desc = 'Goto Definition' }
                )
                vim.keymap.set(
                    'n',
                    'gD',
                    function() Snacks.picker.lsp_declarations() end,
                    { buffer = buf, desc = 'Goto Declaration' }
                )
                vim.keymap.set(
                    'n',
                    'grr',
                    function() Snacks.picker.lsp_references() end,
                    { buffer = buf, desc = 'References', nowait = true }
                )
                vim.keymap.set(
                    'n',
                    'gri',
                    function() Snacks.picker.lsp_implementations() end,
                    { buffer = buf, desc = 'Goto Implementation' }
                )
            end,
        })
    end,
}
