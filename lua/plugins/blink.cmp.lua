return {
    'saghen/blink.cmp',
    dependencies = { 'saghen/blink.lib', 'nvim-mini/mini.icons' },
    lazy = false,
    build = function()
        -- 构建Fuzzy Matcher，等待60秒，可以在:Lazy中使用gb重新构建
        require('blink.cmp').build():wait(60000)
    end,
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
