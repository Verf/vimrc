require'nvim-treesitter.configs'.setup {
    ensure_installed = {"python", "java", "lua"},
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<leader>0",
            node_incremental = "<leader>=",
            scope_incremental = "<leader>+",
            node_decremental = "<leader>-",
        },
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true
    }
}
