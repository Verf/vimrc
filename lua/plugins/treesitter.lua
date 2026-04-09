return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        branch = 'main',
        lazy = false,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        init = function()
            -- nvim-treesitter-textobjects要求关闭所有内置filetype以避免冲突
            vim.g.no_plugin_maps = true
        end,
        keys = {
            {
                'af',
                [[<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')<cr>]],
                mode = { 'x', 'o' },
                desc = 'Outer Function',
            },
            {
                'rf',
                [[<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')<cr>]],
                mode = { 'x', 'o' },
                desc = 'Inner Function',
            },
            {
                'ac',
                [[<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')<cr>]],
                mode = { 'x', 'o' },
                desc = 'Outer Class',
            },
            {
                'rc',
                [[<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')<cr>]],
                mode = { 'x', 'o' },
                desc = 'Inner Class',
            },
            {
                'as',
                [[<cmd>lua require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')<cr>]],
                mode = { 'x', 'o' },
                desc = 'Outer Scope',
            },
            {
                ']f',
                [[<cmd>lua require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Next Function',
            },
            {
                '[f',
                [[<cmd>lua require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Previous Function',
            },
            {
                ']c',
                [[<cmd>lua require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Next Class',
            },
            {
                '[c',
                [[<cmd>lua require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Previous Class',
            },
            {
                ']p',
                [[<cmd>lua require('nvim-treesitter-textobjects.move').goto_next_start('@parameter.outer', 'textobjects')<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Next Parameter',
            },
            {
                '[p',
                [[<cmd>lua require('nvim-treesitter-textobjects.move').goto_previous_start('@parameter.outer', 'textobjects')<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Previous Parameter',
            },
            {
                ']i',
                [[<cmd>lua require('nvim-treesitter-textobjects.move').goto_next_start('@conditional.outer', 'textobjects')<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Next Conditional',
            },
            {
                '[i',
                [[<cmd>lua require('nvim-treesitter-textobjects.move').goto_previous_start('@conditional.outer', 'textobjects')<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Previous Conditional',
            },
            {
                '<leader>sn',
                [[<cmd>lua require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')<cr>]],
                mode = 'n',
                desc = 'Swap parameter to next',
            },
            {
                '<leader>sp',
                [[<cmd>lua require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.outer')<cr>]],
                mode = 'n',
                desc = 'Swap parameter to previous',
            },
            {
                'h',
                [[<cmd>lua require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move_next()<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Repeat last move next',
            },
            {
                ',',
                [[<cmd>lua require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move_previous()<cr>]],
                mode = { 'n', 'x', 'o' },
                desc = 'Repeat last move previous',
            },
        },
        config = function(_, opts)
            local languages = {
                'bash',
                'css',
                'diff',
                'go',
                'html',
                'java',
                'javascript',
                'json',
                'lua',
                'markdown',
                'markdown_inline',
                'nu',
                'python',
                'rust',
                'sql',
                'toml',
                'typescript',
                'vim',
                'vimdoc',
                'yaml',
                'zig',
            }
            -- 确保parser均已安装
            local isnt_installed = function(lang)
                return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
            end
            local to_install = vim.tbl_filter(isnt_installed, languages)
            if #to_install > 0 then require('nvim-treesitter').install(to_install) end

            -- 使用autocmd自动根据filetypes开启Tree-sitter
            local filetypes = {}
            for _, lang in ipairs(languages) do
                for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
                    table.insert(filetypes, ft)
                end
            end
            local ts_start = function(ev) vim.treesitter.start(ev.buf) end
            vim.api.nvim_create_autocmd('FileType', {
                pattern = filetypes,
                callback = function(ev)
                    vim.treesitter.start(ev.buf)
                    vim.wo.foldmethod = 'expr'
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
                desc = 'Start Tree-sitter',
            })
            -- 配置textobjects
            require('nvim-treesitter-textobjects').setup { move = { set_jumps = true } }
        end,
    },
}
