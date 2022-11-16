local nls = require 'null-ls'
nls.setup {
    sources = {
        -- formatting
        nls.builtins.formatting.yapf,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.prettier,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.sql_formatter,
        -- linter
        nls.builtins.formatting.eslint,
    },
}