return {
    'nvim-mini/mini.extra',
    version = false,
    dependencies = { 'nvim-mini/mini.pick', 'nvim-mini/mini.visits' },
    lazy = false,
    keys = {
        { '<leader>h', function() MiniExtra.pickers.oldfiles() end, mode = 'n', desc = 'Oldfiles' },
        {
            '<leader>z',
            function()
                MiniExtra.pickers.visit_paths({
                    filter = function(data) return vim.fn.isdirectory(data.path) == 1 end,
                    cwd = '', -- 默认限制在cwd范围，设置cwd = ''可查询全局
                }, {
                    source = {
                        name = 'Visits',
                        choose = function(item)
                            if item == nil then return end
                            local full_path = vim.fn.fnamemodify(item, ':p')
                            vim.api.nvim_set_current_dir(full_path)
                            vim.notify('cd ' .. full_path, vim.log.levels.INFO)
                        end,
                    },
                })
            end,
            mode = 'n',
            desc = 'Visit Directories',
        },
        {
            '<leader>d',
            function() MiniExtra.pickers.diagnostic { scope = 'current' } end,
            mode = 'n',
            desc = 'Diagnostics',
        },
        {
            '<leader>s',
            function() MiniExtra.pickers.lsp { scope = 'document_symbol' } end,
            mode = 'n',
            desc = 'Symbols',
        },
        -- git
        {
            '<leader>gb',
            function() MiniExtra.pickers.git_branches { scope = 'local' } end,
            mode = 'n',
            desc = 'Find Git Branches',
        },
        {
            '<leader>gfs',
            function() MiniExtra.pickers.git_hunks { path = '%', scope = 'staged' } end,
            mode = 'n',
            desc = 'Find Staged',
        },
        {
            '<leader>gfS',
            function() MiniExtra.pickers.git_hunks { scope = 'staged' } end,
            mode = 'n',
            desc = 'Find All Staged',
        },
        {
            '<leader>gfu',
            function() MiniExtra.pickers.git_hunks { path = '%', scope = 'unstaged' } end,
            mode = 'n',
            desc = 'Find Unstaged',
        },
        {
            '<leader>gfU',
            function() MiniExtra.pickers.git_hunks { scope = 'unstaged' } end,
            mode = 'n',
            desc = 'Find All Unstaged',
        },
        -- lsp
        { 'grr', function() MiniExtra.pickers.lsp { scope = 'references' } end, mode = 'n', desc = 'Goto references' },
        {
            'gri',
            function() MiniExtra.pickers.lsp { scope = 'implementation' } end,
            mode = 'n',
            desc = 'Goto implementation',
        },
        {
            'grt',
            function() MiniExtra.pickers.lsp { scope = 'type_definition' } end,
            mode = 'n',
            desc = 'Goto type_definition',
        },
    },
    opts = {},
}
