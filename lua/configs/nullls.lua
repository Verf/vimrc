local nls = require 'null-ls'
nls.setup {
    sources = {
        -- code action
        nls.builtins.code_actions.eslint.with {
            prefer_local = true,
        },
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
        nls.builtins.diagnostics.eslint.with {
            prefer_local = true,
        },
        nls.builtins.diagnostics.pylint,
    },
}
