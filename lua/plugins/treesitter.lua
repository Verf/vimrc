return {
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
            function()
                require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
            end,
            mode = { 'x', 'o' },
            desc = 'Outer Function',
        },
        {
            'rf',
            function()
                require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
            end,
            mode = { 'x', 'o' },
            desc = 'Inner Function',
        },
        {
            'ac',
            function() require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects') end,
            mode = { 'x', 'o' },
            desc = 'Outer Class',
        },
        {
            'rc',
            function() require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects') end,
            mode = { 'x', 'o' },
            desc = 'Inner Class',
        },
        {
            'as',
            function() require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals') end,
            mode = { 'x', 'o' },
            desc = 'Outer Scope',
        },
        {
            ']f',
            function() require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects') end,
            mode = { 'n', 'x', 'o' },
            desc = 'Next Function',
        },
        {
            '[f',
            function()
                require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
            end,
            mode = { 'n', 'x', 'o' },
            desc = 'Previous Function',
        },
        {
            ']c',
            function() require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects') end,
            mode = { 'n', 'x', 'o' },
            desc = 'Next Class',
        },
        {
            '[c',
            function() require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects') end,
            mode = { 'n', 'x', 'o' },
            desc = 'Previous Class',
        },
        {
            ']p',
            function() require('nvim-treesitter-textobjects.move').goto_next_start('@parameter.outer', 'textobjects') end,
            mode = { 'n', 'x', 'o' },
            desc = 'Next Parameter',
        },
        {
            '[p',
            function()
                require('nvim-treesitter-textobjects.move').goto_previous_start('@parameter.outer', 'textobjects')
            end,
            mode = { 'n', 'x', 'o' },
            desc = 'Previous Parameter',
        },
        {
            ']i',
            function() require('nvim-treesitter-textobjects.move').goto_next_start('@conditional.outer', 'textobjects') end,
            mode = { 'n', 'x', 'o' },
            desc = 'Next Conditional',
        },
        {
            '[i',
            function()
                require('nvim-treesitter-textobjects.move').goto_previous_start('@conditional.outer', 'textobjects')
            end,
            mode = { 'n', 'x', 'o' },
            desc = 'Previous Conditional',
        },
        {
            '<leader>sn',
            function() require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner' end,
            mode = 'n',
            desc = 'Swap parameter to next',
        },
        {
            '<leader>sp',
            function() require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.outer' end,
            mode = 'n',
            desc = 'Swap parameter to previous',
        },
        {
            'h',
            function() require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move_next() end,
            mode = { 'n', 'x', 'o' },
            desc = 'Repeat last move next',
        },
        {
            ',',
            function() require('nvim-treesitter-textobjects.repeatable_move').repeat_last_move_previous() end,
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

        local ts_group = vim.api.nvim_create_augroup('Tree-Sitter', { clear = true })
        -- 为buffer自动启动tree-sitter
        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
            group = ts_group,
            callback = function(ev)
                local buftype = vim.bo[ev.buf].buftype
                local filetype = vim.bo[ev.buf].filetype
                -- 跳过特殊 buffer
                if buftype ~= '' or filetype == '' or filetype == 'qf' or filetype == 'help' then return end
                -- 仅为支持的buffer开启tree-sitter特性
                if vim.tbl_contains(languages, filetype) then
                    vim.treesitter.start(ev.buf)
                    vim.wo.foldmethod = 'expr'
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })

        -- 设置tree-sitter快捷键
        vim.api.nvim_create_autocmd('FileType', {
            group = ts_group,
            pattern = languages,
            callback = function(ev)
                local buftype = vim.bo[ev.buf].buftype
                -- 跳过特殊 buffer
                if buftype ~= '' or filetype == '' or filetype == 'qf' or filetype == 'help' then return end
                -- 增量选择快捷键
                vim.keymap.set({ 'n', 'x' }, '<CR>', function()
                    if vim.treesitter.get_parser(ev.buf, nil, { error = false }) then
                        require('vim.treesitter._select').select_parent(vim.v.count1 or 1)
                    else
                        vim.lsp.buf.selection_range(vim.v.count1)
                    end
                end, { buffer = ev.buf, desc = 'Incremental expand selection', silent = true })
                vim.keymap.set('x', '<bs>', function()
                    if vim.treesitter.get_parser(nil, nil, { error = false }) then
                        require('vim.treesitter._select').select_child(vim.v.count1)
                    else
                        vim.lsp.buf.selection_range(-vim.v.count1)
                    end
                end, { buffer = ev.buf, desc = 'Shrink selection', silent = true })
            end,
        })

        -- 配置textobjects
        require('nvim-treesitter-textobjects').setup { move = { set_jumps = true } }
    end,
}
