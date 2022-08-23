local defaults = require 'formatter.defaults'
local util = require 'formatter.util'

require('formatter').setup {
    filetype = {
        javascript = require('formatter.filetypes.javascript').prettier,
        typescript = require('formatter.filetypes.typescript').prettier,
        html = require('formatter.filetypes.html').prettier,
        css = require('formatter.filetypes.css').prettier,
        json = require('formatter.filetypes.json').prettier,
        vue = util.withl(defaults.prettier, 'vue'),
        less = util.withl(defaults.prettier, 'less'),
        scss = util.withl(defaults.prettier, 'scss'),
        markdown = util.withl(defaults.prettier, 'markdown'),
        yaml = util.withl(defaults.prettier, 'yaml'),
        lua = require('formatter.filetypes.lua').stylua,
        sh = require('formatter.filetypes.sh').shfmt,
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
    },
}
