local null_ls = require 'null-ls'
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
    debug = true,
    sources = {
        formatting.prettier.with {
            command = 'prettier.cmd',
            extra_args = {
                '--single-quote',
                '--jsx-single-quote',
            },
        },
        formatting.yapf,
        formatting.stylua.with { command = 'stylua.exe' },
        formatting.shfmt,
    },
}
