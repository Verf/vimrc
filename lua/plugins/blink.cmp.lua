return {
    'saghen/blink.cmp',
    dependencies = { 'saghen/blink.lib', 'nvim-mini/mini.icons' },
    lazy = false,
    opts = {
        keymap = {
            preset = 'none',
            ['<C-e>'] = { 'hide', 'show' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },
        fuzzy = { implementation = 'lua' },
        snippets = { preset = 'mini_snippets' },
        sources = { default = { 'lsp', 'path', 'buffer' } },
        cmdline = { enabled = false },
        completion = {
            list = { selection = { preselect = false } },
            menu = {
                border = nil,
                draw = {
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                return kind_icon
                            end,
                        },
                    },
                },
            },
        },
    },
}
