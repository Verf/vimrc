local formatter = require 'formatter.filetypes'
local defaults = require 'formatter.defaults'
local util = require 'formatter.util'

require('formatter').setup {
    filetype = {
        javascript = formatter.javascript.prettier,
        typescript = formatter.typescript.prettier,
        html = formatter.html.prettier,
        css = formatter.css.prettier,
        json = formatter.json.prettier,
        vue = util.withl(defaults.prettier, 'vue'),
        less = util.withl(defaults.prettier, 'less'),
        scss = util.withl(defaults.prettier, 'scss'),
        markdown = util.withl(defaults.prettier, 'markdown'),
        yaml = util.withl(defaults.prettier, 'yaml'),
        lua = formatter.lua.stylua,
        sh = formatter.sh.shfmt,
        python = {
            function()
                return {
                    exe = 'blue',
                    args = { '-q', '-' },
                    stdin = true,
                }
            end,
        },
        go = formatter.go.goimports,
    },
}
