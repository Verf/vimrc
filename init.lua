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

-- 全局配置
_G.Config = {}
-- 全局autocmd group
_G.MyGroup = vim.api.nvim_create_augroup('MyGroup', { clear = true })
