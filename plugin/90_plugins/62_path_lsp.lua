-- path-lsp: 文件系统路径补全 LSP
-- 使用 Neovim 内嵌 function transport，无外部进程依赖。
Config.now(function()
    local path_lsp = require 'plugins.path_lsp'

    -- 仅在 buffer 首次获得文件名时启动（BufNewFile 覆盖新文件，BufReadPost 覆盖首次读取），
    -- 去掉 BufWinEnter/BufEnter 避免每次切换 buffer 都重复遍历 LSP client 列表和 .git 查找
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
        group = _G.MyGroup,
        callback = function(args) path_lsp.start(args.buf) end,
        desc = 'Start path-lsp on buffer open',
    })
end)
