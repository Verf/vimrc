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

-- 定义autocm的帮助函数
local gr = vim.api.nvim_create_augroup('custom-config', {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
    local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
    vim.api.nvim_create_autocmd(event, opts)
end
