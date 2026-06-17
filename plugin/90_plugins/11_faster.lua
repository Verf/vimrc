-- faster.nvim 的替代实现，见 lua/plugins/faster.lua
-- 功能：大文件/长行文件/宏执行时自动禁用 treesitter/lsp/syntax 等重功能
Config.now(function()
    require('plugins.faster').setup()
end)
