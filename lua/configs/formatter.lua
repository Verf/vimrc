require('formatter').setup {
    filetype = {
        javascript = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        typescript = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        html = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        css = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        json = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        vue = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        less = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        scss = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        markdown = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        yaml = {
            function()
                return {
                    exe = 'prettier',
                    args = { '--stdin-filepath', vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote' },
                    stdin = true,
                }
            end,
        },
        lua = {
            function()
                return {
                    exe = 'stylua',
                    args = {
                        '--search-parent-directories',
                        '-',
                    },
                    stdin = true,
                }
            end,
        },
        sh = {
            function()
                return {
                    exe = 'shfmt',
                    args = { '-i', 2 },
                    stdin = true,
                }
            end,
        },
        python = {
            function()
                return {
                    exe = 'yapf',
                    args = { '--style={column_limit: 120}' },
                    stdin = true,
                }
            end,
        },
        go = {
            function()
                return {
                    exe = 'goimports',
                    args = {},
                    stdin = true,
                }
            end,
        },
    },
}
