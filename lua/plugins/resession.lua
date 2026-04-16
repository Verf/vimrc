return {
    'stevearc/resession.nvim',
    lazy = false,
    keys = {
        {
            '<leader>ss',
            function() require('resession').save_tab(vim.fn.getcwd(), { dir = 'dirsession', notify = true }) end,
            mode = 'n',
            desc = 'Session Save',
        },
        {
            '<leader>sl',
            function() require('resession').load(vim.fn.getcwd(), { dir = 'dirsession', silence_errors = true }) end,
            mode = 'n',
            desc = 'Session Load',
        },
        {
            '<leader>sd',
            function() require('resession').delete(vim.fn.getcwd(), { dir = 'dirsession', notify = true }) end,
            mode = 'n',
            desc = 'Session Delete',
        },
    },
    opts = {
        -- 为scope.nvim配置过滤器
        buf_filter = function(bufnr)
            local buftype = vim.bo[bufnr].buftype
            if buftype == 'help' then return true end
            if buftype ~= '' and buftype ~= 'acwrite' then return false end
            if vim.api.nvim_buf_get_name(bufnr) == '' then return false end
            return true
        end,
        -- 添加scope.nvim扩展
        extensions = { scope = {}, overseer = {} },
    },
}
