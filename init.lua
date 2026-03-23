--   __      _______ __  __ _____   _____
--   \ \    / /_   _|  \/  |  __ \ / ____|
--    \ \  / /  | | | \  / | |__) | |
--     \ \/ /   | | | |\/| |  _  /| |
--      \  /   _| |_| |  | | | \ \| |____
--       \/   |_____|_|  |_|_|  \_\\_____|
--
--  For Verf
--
if vim.loader then vim.loader.enable() end

-- 安装mini.nvim
local mini_path = vim.fn.stdpath 'data' .. '/site/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd 'echo "正在安装 `mini.nvim`" | redraw'
    local origin = 'https://github.com/nvim-mini/mini.nvim'
    local clone_cmd = { 'git', 'clone', '--filter=blob:none', origin, mini_path }
    vim.fn.system(clone_cmd)
    vim.cmd 'packadd mini.nvim | helptags ALL'
    vim.cmd 'echo "安装 `mini.nvim` 完成" | redraw'
end

-- 使用mini.deps作为包管理器
-- 待neovim 0.12发布后替换为vim.pack
require('mini.deps').setup()

-- 全局变量表用于共享配置
_G.Config = {}

-- now_if_args根据nvim启动时是否打开文件(通过参数数量)来决定插件应该立刻加载还是延后加载
-- 如果nvim打开一个文件，则一些文件编辑相关的插件应该立刻启动，否则可以延后
_G.Config.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

-- 定义autocmd的帮助函数
local gr = vim.api.nvim_create_augroup('custom-config', {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
    local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
    vim.api.nvim_create_autocmd(event, opts)
end

-- 失去焦点时自动保存
_G.Config.new_autocmd({ 'FocusLost', 'BufLeave' }, '*', function()
    local bufnr = vim.api.nvim_get_current_buf()

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
    vim.cmd 'silent! update'
end, 'Auto save when focus lost')
