return {
    'saghen/blink.cmp',
    version = 'v1.10.1', -- 你原来指定的版本
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {
        keymap = {
            preset = 'none',
            ['<cr>'] = { 'accept', 'fallback' },
            ['<C-e>'] = { 'hide', 'show' },
            ['<C-y>'] = { 'select_and_accept', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },
        snippets = { preset = 'mini_snippets' },
        sources = { default = { 'lsp', 'buffer', 'path' } },
        signature = { enabled = true },
        completion = {
            list = { selection = { preselect = false, auto_insert = true } },
            trigger = { show_on_keyword = true, show_on_trigger_character = false },
            menu = {
                draw = {
                    padding = { 0, 1 },
                    components = {
                        kind_icon = {
                            highlight = function(ctx)
                                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                    },
                },
            },
        },
        cmdline = {
            completion = {
                menu = { auto_show = true },
                list = { selection = { preselect = false, auto_insert = true } },
            },
        },
    },
    config = function(_, opts)
        require('blink.cmp').setup(opts)

        -- 退出插入模式时自动关闭自动补全菜单
        vim.api.nvim_create_autocmd('InsertLeave', {
            callback = function()
                vim.schedule(function() require('blink.cmp').cancel() end)
            end,
        })
    end,
}
