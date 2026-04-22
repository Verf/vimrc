return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    lazy = false,
    config = function(_, opts)
        local languages = {
            -- config
            'xml',
            'json',
            'yaml',
            'toml',
            -- git
            'diff',
            -- text
            'regex',
            -- front & vue
            'vue',
            'html',
            'css',
            'javascript',
            'typescript',
            'tsx',
            'scss',
            -- backend
            'java',
            'javadoc',
            'properties',
            -- python
            'python',
            'rst',
            -- shell & sql
            'nu',
            'bash',
            'sql',
        }
        -- 确保parser均已安装
        local isnt_installed = function(lang)
            return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
        end
        local to_install = vim.tbl_filter(isnt_installed, languages)
        if #to_install > 0 then require('nvim-treesitter').install(to_install) end

        -- 插入Neovim自带的tree-sitter
        for _, lang in ipairs { 'c', 'lua', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' } do
            table.insert(languages, lang)
        end

        local filetypes = {}
        for _, lang in ipairs(languages) do
            for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
                table.insert(filetypes, ft)
            end
        end

        -- 为buffer自动启动tree-sitter
        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
            group = _G.my_group,
            callback = function(ev)
                local buftype = vim.bo[ev.buf].buftype
                local filetype = vim.bo[ev.buf].filetype
                local lang = vim.treesitter.language.get_lang(filetype)
                -- 跳过特殊 buffer
                if buftype ~= '' or filetype == '' or filetype == 'qf' or filetype == 'help' then return end
                -- 仅为支持的buffer开启tree-sitter特性
                if vim.tbl_contains(filetypes, filetype) then
                    vim.treesitter.start(ev.buf)
                    vim.wo.foldmethod = 'expr'
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    local indents = vim.treesitter.query.get(lang, 'indents')
                    if indents then vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
                end
            end,
        })

        -- 设置tree-sitter快捷键
        vim.api.nvim_create_autocmd('FileType', {
            group = _G.my_group,
            pattern = filetypes,
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
    end,
}
