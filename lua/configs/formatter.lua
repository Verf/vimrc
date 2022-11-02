local util = require 'formatter.util'

require('formatter').setup {
    filetype = {
        javascript = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        typescript = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        html = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        css = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        json = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        less = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        scss = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        markdown = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        yaml = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        lua = { require('formatter.filetypes.lua').stylua },
        sh = { require('formatter.filetypes.sh').shfmt },
        vue = {
            function()
                return {
                    exe = 'prettier',
                    args = {
                        '--stdin-filepath',
                        util.escape_path(util.get_current_buffer_file_path()),
                        '--single-quote',
                    },
                    stdin = true,
                    try_node_module = true,
                }
            end,
        },
        python = {
            function()
                return {
                    exe = 'blue',
                    args = { '-q', '-' },
                    stdin = true,
                }
            end,
        },
        go = require('formatter.filetypes.go').goimports,
        sql = {
            function()
                return {
                    exe = 'sql-formatter',
                    args = {},
                    stdin = true,
                }
            end,
        },
    },
}
