require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'python',
        'java',
        'lua',
        'html',
        'vue',
        'javascript',
        'typescript',
        'css',
        'json',
        'go',
        'markdown',
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
        disable = { 'python' },
    },
    incremental_selection = {
        enable = false,
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['rf'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['rc'] = '@class.inner',
                ['am'] = '@parameter.outer',
                ['rm'] = '@parameter.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']f'] = '@function.outer',
                [']c'] = '@class.outer',
            },
            goto_next_end = {
                [']F'] = '@function.outer',
                [']C'] = '@class.outer',
            },
            goto_previous_start = {
                ['[f'] = '@function.outer',
                ['[c'] = '@class.outer',
            },
            goto_previous_end = {
                ['[F'] = '@function.outer',
                ['[C'] = '@class.outer',
            },
        },
    },
    textsubjects = {
        enable = true,
        keymaps = {
            ['<CR>'] = 'textsubjects-smart',
            ['<S-CR>'] = 'textsubjects-container-outer',
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 2000,
    },
    autotag = {
        enable = true,
    },
    matchup = {
        enable = true,
    },
    yati = { enable = true },
}
