return {
    'nvim-mini/mini.sessions',
    version = false,
    lazy = false,
    keys = {
        { '<leader>Ss', function() require('mini.sessions').select() end, mode = 'n', desc = 'Select Session' },
        {
            '<leader>Sw',
            function()
                local name = vim.fn.input 'Session name: '
                if name ~= '' then require('mini.sessions').write(name) end
            end,
            mode = 'n',
            desc = 'Write Session',
        },
        {
            '<leader>Sd',
            function()
                local name = vim.fn.input 'Session name: '
                if name ~= '' then require('mini.sessions').delete(name) end
            end,
            mode = 'n',
            desc = 'Delete Session',
        },
    },
    opts = {
        autowrite = true,
        file = '',
        hooks = {
            pre = {
                write = function()
                    -- 清理无用的空 buffer
                    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                        if
                            vim.api.nvim_buf_get_name(bufnr) == ''
                            and vim.api.nvim_buf_get_option(bufnr, 'buftype') == ''
                        then
                            pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
                        end
                    end
                end,
            },
            post = {
                read = function()
                    -- 避免Lsp或语法高亮在加载session后可能未正常激活
                    vim.cmd 'doautoall BufReadPost'
                end,
            },
        },
    },
}
