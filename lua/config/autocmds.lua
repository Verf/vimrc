local my_group = vim.api.nvim_create_augroup('MyAutoCmdGroup', { clear = true })

-- grep或make后自动打开quickfix
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    pattern = '[^l]*', -- 匹配 grep, make 等（排除 lgrep 等局部列表命令）
    group = my_group,
    callback = function()
        vim.cmd 'cwindow' -- 有结果才打开，没结果不打开
    end,
})

-- 在当前注释中按o插入新行后不自动添加注释符，在 FileType 时调用以自动覆盖文件类似特定的配置
vim.api.nvim_create_autocmd('FileType', {
    group = my_group,
    callback = function() vim.cmd 'setlocal formatoptions-=c formatoptions-=o' end,
    desc = "Proper 'formatoptions'",
})

local save_buffer = function(bufnr)
    -- 1. 检查 Buffer 是否被修改过 (modified)
    if not vim.api.nvim_buf_get_option(bufnr, 'modified') then return end
    -- 2. 检查文件名是否为空 (排除未命名的新文件)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname == '' then return end
    -- 3. 排除特定的 buftype (只保存普通文件)
    -- 排除：terminal, prompt, quickfix, nofile (如 NvimTree, Telescope 等)
    local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
    if buftype ~= '' then return end
    -- 4. 排除只读文件
    if vim.api.nvim_buf_get_option(bufnr, 'readonly') then return end
    -- 5. 排除特定的 filetype
    local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
    local exclude_ft = { 'gitcommit', 'gitrebase' }
    if vim.tbl_contains(exclude_ft, filetype) then return end
    -- 执行保存：silent! 忽略可能产生的错误（如权限不足），update 仅在有改动时写入
    pcall(function()
        vim.api.nvim_buf_call(bufnr, function() vim.cmd 'silent! update' end)
    end)
end

-- 失去焦点时自动保存
vim.api.nvim_create_autocmd({ 'FocusLost', 'BufLeave' }, {
    group = my_group,
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        save_buffer(bufnr)
    end,
    desc = 'Auto save when focus lost',
})

-- 退出neovim时自动保存
vim.api.nvim_create_autocmd('QuitPre', {
    group = my_group,
    callback = function()
        -- 遍历所有 buffer
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if not vim.api.nvim_buf_is_valid(bufnr) then goto continue end
            save_buffer(bufnr)
            ::continue::
        end
    end,
    desc = 'Auto save all valid buffers when leave neovim',
})

-- help / man 默认竖向分屏
vim.api.nvim_create_autocmd('FileType', {
    group = my_group,
    pattern = { 'help', 'man' },
    command = 'wincmd L',
})
