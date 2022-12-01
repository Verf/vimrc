local nls = require 'null-ls'
nls.setup {
    sources = {
        -- formatting
        nls.builtins.formatting.blue,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.prettier.with {
            prefer_local = true,
        },
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.sql_formatter,
        -- linter
        nls.builtins.formatting.eslint,
    },
}
