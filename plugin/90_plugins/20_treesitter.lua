vim.pack.add { 'https://github.com/arborist-ts/arborist.nvim' }

Config.now(function()
    require('arborist').setup {
        prefer_wasm = false,
        compiler = 'zig',
        update_cadence = 'weekly',
        install_popular = false,
        ensure_installed = {
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
            'http',
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
        },
    }

    -- 设置tree-sitter快捷键
    vim.api.nvim_create_autocmd('FileType', {
        group = _G.MyGroup,
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
end)
