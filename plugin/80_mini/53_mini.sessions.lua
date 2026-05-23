-- mini.sessions
require('mini.sessions').setup {
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
}

vim.keymap.set('n', '<leader>Ss', function() require('mini.sessions').select() end, { desc = 'Select Session' })
vim.keymap.set('n', '<leader>Sw', function()
    local name = vim.fn.input 'Session name: '
    if name ~= '' then require('mini.sessions').write(name) end
end, { desc = 'Write Session' })
vim.keymap.set('n', '<leader>Sd', function()
    local name = vim.fn.input 'Session name: '
    if name ~= '' then require('mini.sessions').delete(name) end
end, { desc = 'Delete Session' })
