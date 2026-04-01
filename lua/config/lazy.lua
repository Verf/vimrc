-- 安装lazy.nvim 来自: https://lazy.folke.io/installation
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { '下载 lazy.nvim 失败:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\n按任意键退出...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- 配置lazy.nvim，并自动导入其他插件配置
require('lazy').setup {
    spec = {
        { import = 'plugins' },
    },
    install = { colorscheme = { 'default' } },
    checker = { enabled = true },
}
