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

-- 装载mini.nvim用于构建lazy load
vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

-- 全局变量表用于共享配置
_G.Config = {}

-- 定义lazy load帮助函数
local misc = require 'mini.misc'
Config.now = function(f) misc.safely('now', f) end
Config.later = function(f) misc.safely('later', f) end
Config.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end
-- now_if_args根据nvim启动时是否打开文件(通过参数数量)来决定插件应该立刻加载还是延后加载
-- 如果nvim打开一个文件，则一些文件编辑相关的插件应该立刻启动，否则可以延后
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later

-- 定义autocmd的帮助函数
local gr = vim.api.nvim_create_augroup('custom-config', {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
    local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
    vim.api.nvim_create_autocmd(event, opts)
end

-- 当PackChanged时自动加载插件
Config.on_packchanged = function(plugin_name, kinds, callback, desc)
    local f = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
        if not ev.data.active then vim.cmd.packadd(plugin_name) end
        callback()
    end
    Config.new_autocmd('PackChanged', '*', f, desc)
end
