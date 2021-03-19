" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "C:\\Users\\Verf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\Verf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\Verf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\Verf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\Verf\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  LeaderF = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\LeaderF"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lexima.vim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n∞\4\0\0\6\0\28\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\v\0004\4\3\0005\5\n\0>\5\1\4=\4\f\0034\4\3\0005\5\r\0>\5\1\4=\4\14\0034\4\3\0005\5\15\0>\5\1\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\3=\3\23\0025\3\24\0004\4\0\0=\4\f\0034\4\0\0=\4\14\0035\4\25\0=\4\16\0035\4\26\0=\4\18\0034\4\0\0=\4\20\0034\4\0\0=\4\22\3=\3\27\2B\0\2\1K\0\1\0\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\1\0\rfilename\16file_status\2\14lualine_b\1\2\1\0\vbranch\ticon\bÓÇ†\14lualine_a\1\0\0\1\2\1\0\tmode\nupper\2\foptions\1\0\0\25component_separators\1\3\0\0\6|\6|\23section_separators\1\3\0\0\bÓÇ∞\bÓÇ≤\1\0\2\ntheme\fonedark\18icons_enabled\2\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim"
  },
  neoformat = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neoformat"
  },
  nerdcommenter = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nerdcommenter"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\n\31\0\2\5\0\2\0\5'\2\0\0\18\3\0\0'\4\1\0&\2\4\2L\2\2\0\6)\6(º\3\1\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0003\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\0\26diagnostics_indicator\0\1\0\17\23right_trunc_marker\bÔÇ©\22left_trunc_marker\bÔÇ®\15close_icon\bÔÄç\18modified_icon\b‚óè\22buffer_close_icon\bÔôï\27always_show_bufferline\2\fnumbers\tnone\tview\16multiwindow\fsort_by\14extension\25enforce_regular_tabs\1\20separator_style\tthin\24persist_buffer_sort\2\28show_buffer_close_icons\1\16diagnostics\rnvim_lsp\rtab_size\3\18\22max_prefix_length\3\15\20max_name_length\3\18\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-bufferline.lua"
  },
  ["nvim-compe"] = {
    config = { "\27LJ\2\nª\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\vsource\1\0\a\rnvim_lua\2\14ultisnips\2\rnvim_lsp\2\vvsnips\1\tpath\2\tcalc\2\vbuffer\2\1\0\f\18documentation\2\19max_menu_width\3d\ndebug\1\19max_abbr_width\3d\21incomplete_delay\3ê\3\19source_timeout\3»\1\18throttle_time\3P\19max_kind_width\3d\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\nsetup\ncompe\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-compe"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n‚\5\0\2\a\0\t\0\0186\2\0\0009\2\1\0029\2\2\2\18\4\1\0'\5\3\0'\6\4\0B\2\4\0019\2\5\0009\2\6\2\15\0\2\0X\3\6Ä6\2\0\0009\2\1\0029\2\a\2'\4\b\0+\5\1\0B\2\3\1K\0\1\0ß\4                    hi LspReferenceRead term=underline cterm=underline gui=underline\n                    hi LspReferenceText term=underline cterm=underline gui=underline\n                    hi LspReferenceWrite term=underline cterm=underline gui=underline\n                    augroup lsp_document_highlight\n                    au!\n                    au CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n                    au CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n                    augroup END\n                        \14nvim_exec\23document_highlight\26resolved_capabilities\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\bvimÑ\1\1\0\v\0\b\0\0176\0\0\0'\2\1\0B\0\2\0023\1\2\0005\2\3\0006\3\4\0\18\5\2\0B\3\2\4X\6\5Ä8\b\a\0009\b\5\b5\n\6\0=\1\a\nB\b\2\1E\6\3\3R\6˘K\0\1\0\14on_attach\1\0\0\nsetup\vipairs\1\2\0\0\fpyright\0\14lspconfig\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nì\3\0\0\a\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\15\0005\4\n\0005\5\v\0005\6\f\0=\6\r\5=\5\14\4=\4\16\3=\3\17\2B\0\2\1K\0\1\0\16textobjects\vselect\1\0\0\fkeymaps\aiF\1\0\2\tjava#(method_declaration) @function\vpython$(function_definition) @function\1\0\4\aic\17@class.inner\aac\17@class.outer\aif\20@function.inner\aaf\20@function.outer\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\4\0\0\vpython\tjava\blua\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim"
  },
  sonokai = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\sonokai"
  },
  supertab = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\supertab"
  },
  ultisnips = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\ultisnips"
  },
  ["vim-auto-save"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-auto-save"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-easy-align"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-easymotion"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-floaterm"
  },
  ["vim-lastplace"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-lastplace"
  },
  ["vim-markdown"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-markdown"
  },
  ["vim-mundo"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-mundo"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-polyglot"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-repeat"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-rooter"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-surround"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-visual-multi"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "C:\\Users\\Verf\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vista.vim"
  }
}

-- Config for: nvim-web-devicons
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
-- Config for: lspkind-nvim
try_loadstring("\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
-- Config for: nvim-treesitter
try_loadstring("\27LJ\2\nì\3\0\0\a\0\18\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\15\0005\4\n\0005\5\v\0005\6\f\0=\6\r\5=\5\14\4=\4\16\3=\3\17\2B\0\2\1K\0\1\0\16textobjects\vselect\1\0\0\fkeymaps\aiF\1\0\2\tjava#(method_declaration) @function\vpython$(function_definition) @function\1\0\4\aic\17@class.inner\aac\17@class.outer\aif\20@function.inner\aaf\20@function.outer\1\0\1\venable\2\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\4\0\0\vpython\tjava\blua\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\n‚\5\0\2\a\0\t\0\0186\2\0\0009\2\1\0029\2\2\2\18\4\1\0'\5\3\0'\6\4\0B\2\4\0019\2\5\0009\2\6\2\15\0\2\0X\3\6Ä6\2\0\0009\2\1\0029\2\a\2'\4\b\0+\5\1\0B\2\3\1K\0\1\0ß\4                    hi LspReferenceRead term=underline cterm=underline gui=underline\n                    hi LspReferenceText term=underline cterm=underline gui=underline\n                    hi LspReferenceWrite term=underline cterm=underline gui=underline\n                    augroup lsp_document_highlight\n                    au!\n                    au CursorHold <buffer> lua vim.lsp.buf.document_highlight()\n                    au CursorMoved <buffer> lua vim.lsp.buf.clear_references()\n                    augroup END\n                        \14nvim_exec\23document_highlight\26resolved_capabilities\27v:lua.vim.lsp.omnifunc\romnifunc\24nvim_buf_set_option\bapi\bvimÑ\1\1\0\v\0\b\0\0176\0\0\0'\2\1\0B\0\2\0023\1\2\0005\2\3\0006\3\4\0\18\5\2\0B\3\2\4X\6\5Ä8\b\a\0009\b\5\b5\n\6\0=\1\a\nB\b\2\1E\6\3\3R\6˘K\0\1\0\14on_attach\1\0\0\nsetup\vipairs\1\2\0\0\fpyright\0\14lspconfig\frequire\0", "config", "nvim-lspconfig")
-- Config for: nvim-bufferline.lua
try_loadstring("\27LJ\2\n\31\0\2\5\0\2\0\5'\2\0\0\18\3\0\0'\4\1\0&\2\4\2L\2\2\0\6)\6(º\3\1\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\3\0003\4\4\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\0\26diagnostics_indicator\0\1\0\17\23right_trunc_marker\bÔÇ©\22left_trunc_marker\bÔÇ®\15close_icon\bÔÄç\18modified_icon\b‚óè\22buffer_close_icon\bÔôï\27always_show_bufferline\2\fnumbers\tnone\tview\16multiwindow\fsort_by\14extension\25enforce_regular_tabs\1\20separator_style\tthin\24persist_buffer_sort\2\28show_buffer_close_icons\1\16diagnostics\rnvim_lsp\rtab_size\3\18\22max_prefix_length\3\15\20max_name_length\3\18\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
-- Config for: lualine.nvim
try_loadstring("\27LJ\2\n∞\4\0\0\6\0\28\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\v\0004\4\3\0005\5\n\0>\5\1\4=\4\f\0034\4\3\0005\5\r\0>\5\1\4=\4\14\0034\4\3\0005\5\15\0>\5\1\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\3=\3\23\0025\3\24\0004\4\0\0=\4\f\0034\4\0\0=\4\14\0035\4\25\0=\4\16\0035\4\26\0=\4\18\0034\4\0\0=\4\20\0034\4\0\0=\4\22\3=\3\27\2B\0\2\1K\0\1\0\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\1\0\rfilename\16file_status\2\14lualine_b\1\2\1\0\vbranch\ticon\bÓÇ†\14lualine_a\1\0\0\1\2\1\0\tmode\nupper\2\foptions\1\0\0\25component_separators\1\3\0\0\6|\6|\23section_separators\1\3\0\0\bÓÇ∞\bÓÇ≤\1\0\2\ntheme\fonedark\18icons_enabled\2\nsetup\flualine\frequire\0", "config", "lualine.nvim")
-- Config for: nvim-compe
try_loadstring("\27LJ\2\nª\2\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\vsource\1\0\a\rnvim_lua\2\14ultisnips\2\rnvim_lsp\2\vvsnips\1\tpath\2\tcalc\2\vbuffer\2\1\0\f\18documentation\2\19max_menu_width\3d\ndebug\1\19max_abbr_width\3d\21incomplete_delay\3ê\3\19source_timeout\3»\1\18throttle_time\3P\19max_kind_width\3d\14preselect\venable\15min_length\3\1\17autocomplete\2\fenabled\2\nsetup\ncompe\frequire\0", "config", "nvim-compe")
-- Config for: lspsaga.nvim
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
