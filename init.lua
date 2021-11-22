--   __      _______ __  __ _____   _____
--   \ \    / /_   _|  \/  |  __ \ / ____|
--    \ \  / /  | | | \  / | |__) | |
--     \ \/ /   | | | |\/| |  _  /| |
--      \  /   _| |_| |  | | | \ \| |____
--       \/   |_____|_|  |_|_|  \_\\_____|
--
--  For Verf
local g = vim.g
local cmd = vim.cmd

-- Disable builtin module
local disabled_builtin = {
    'ftPlugin', 'matchit', 'matchparen','gzip', 'man', 'tarPlugin', 'tar','zipPlugin', 'zip', 'netrw', 'netrwPlugin', '2html_plugin',
}

for i = 1, 9 do g['loaded_' .. disabled_builtin[i]] = 1 end

-- disable default filetype.vim
vim.g.did_load_filetypes = 1

-- packer
cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

-- require
require 'settings'
require 'personal'
require 'mappings'
