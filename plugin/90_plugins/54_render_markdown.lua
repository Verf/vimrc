vim.pack.add { 'https://github.com/meanderingprogrammer/render-markdown.nvim' }

Config.now(function()
    require('render-markdown').setup {
        -- 保留代码块首尾围栏和语言原文，不隐藏整行，也不以虚拟标题覆盖。
        code = {
            conceal_delimiters = false,
            language = false,
            border = 'none',
        },
        -- Setext 标题渲染会隐藏下划线所在行，保留原文。
        heading = { setext = false },
        -- 不省略 HTML 注释或以转换后的公式替代原文。
        html = { comment = { conceal = false } },
        latex = { enabled = false },
        -- 禁用 Tree-sitter 对代码围栏的整行隐藏规则。
        patterns = { markdown = { disable = true } },
    }
end)
