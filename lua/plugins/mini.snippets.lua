return {
    'nvim-mini/mini.snippets',
    version = '*',
    lazy = false,
    config = function()
        local snippets = require 'mini.snippets'
        snippets.setup {
            snippets = {
                snippets.gen_loader.from_file(vim.fn.stdpath 'config' .. '/snippets/global.json'),
                snippets.gen_loader.from_lang { lang_patterns = { markdown_inline = { 'markdown.json' } } },
            },
            mappings = { expand = '', jump_next = '', jump_prev = '', stop = '<C-c>' },
            expand = {
                match = function(snips)
                    -- 确保仅会在精确匹配prefix时展开snippet
                    return snippets.default_match(snips, {
                        pattern_exact_boundary = '[^%w_]?',
                        pattern_fuzzy = '',
                    })
                end,
            },
        }

        -- 退出Insert模式时自动停止snippet状态
        vim.api.nvim_create_autocmd('InsertLeave', {
            group = _G.my_group,
            callback = function()
                if snippets.session.get() then
                    vim.schedule(function()
                        while snippets.session.get() do
                            snippets.session.stop()
                        end
                    end)
                end
            end,
        })
    end,
}
