require('formatter').setup({
    logging = false,
    filetype = {
        python = {
            function()
                return {
                    exe = "yapf",
                    args = {},
                    stdin = true,
                }
            end
        },
        vue = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
        javascript = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
        typescript = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
        css = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
        html = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
        less = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
        scss = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
        json = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
        markdown = {
            function ()
                return {
                    exe = "prettier.cmd",
                    args = {'--stdin-filepath', vim.fn.shellescape(vim.api.nvim_buf_get_name(0)),},
                    stdin = true,
                }
            end
        },
    }
})
