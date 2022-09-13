local util = require 'formatter.util'

require('formatter').setup {
    filetype = {
        javascript = require('formatter.filetypes.javascript').prettier,
        typescript = require('formatter.filetypes.typescript').prettier,
        html = require('formatter.filetypes.html').prettier,
        css = require('formatter.filetypes.css').prettier,
        json = require('formatter.filetypes.json').prettier,
        less = require('formatter.filetypes.css').prettier,
        scss = require('formatter.filetypes.css').prettier,
        markdown = require('formatter.filetypes.markdown').prettier,
        yaml = require('formatter.filetypes.yaml').prettier,
        lua = require('formatter.filetypes.lua').stylua,
        sh = require('formatter.filetypes.sh').shfmt,
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
            function ()
                return {
                    exe = 'sql-formatter',
                    args = {},
                    stdin = true,
                }
            end
        }
    },
}
