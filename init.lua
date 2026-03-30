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

-- 全局变量表用于共享配置
_G.Config = {}

-- 定义autocmd的帮助函数
local gr = vim.api.nvim_create_augroup('custom-config', {})
_G.Config.new_autocmd = function(event, pattern, callback, desc)
    local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
    vim.api.nvim_create_autocmd(event, opts)
end
