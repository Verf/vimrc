return {
    'stevearc/resession.nvim',
    lazy = false,
    keys = {
        { '<leader>ss', function() require('resession').save() end, mode = 'n', desc = 'Session Save' },
        { '<leader>sl', function() require('resession').load() end, mode = 'n', desc = 'Session Load' },
        { '<leader>sd', function() require('resession').delete() end, mode = 'n', desc = 'Session Delete' },
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
        extensions = { scope = {} },
    },
    config = function(_, opts)
        local resession = require 'resession'
        resession.setup(opts)

        vim.api.nvim_create_autocmd('VimEnter', {
            callback = function()
                -- 仅当neovim不加参数或stdin输入启动时恢复session
                if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
                    -- 将session存储在dirsession目录下
                    resession.load(vim.fn.getcwd(), { dir = 'dirsession', silence_errors = true })
                end
            end,
            nested = true,
        })
        vim.api.nvim_create_autocmd('VimLeavePre', {
            callback = function() resession.save_tab(vim.fn.getcwd(), { dir = 'dirsession', notify = false }) end,
        })
        vim.api.nvim_create_autocmd('StdinReadPre', {
            callback = function() vim.g.using_stdin = true end,
        })
    end,
}
