----------- Functions ---------------
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

----------- Mappings ----------------
-- Norman Keyboard Layout
map('', 'd', 'e')
map('', 'f', 'r')
map('', 'k', 't')
map('', 'j', 'y')
map('', 'r', 'i')
map('', 'l', 'o')
map('', 'h', 'p')
map('', 'e', 'd')
map('', 't', 'f')
map('', 'g', 'g')
map('', 'y', 'h')
map('', 'n', 'j')
map('', 'i', 'k')
map('', 'o', 'l')
map('', 'p', 'n')
map('', 'D', 'E')
map('', 'F', 'R')
map('', 'K', 'T')
map('', 'J', 'Y')
map('', 'R', 'I')
map('', 'L', 'O')
map('', 'H', 'P')
map('', 'E', 'D')
map('', 'T', 'F')
map('', 'Y', 'H')
map('', 'N', 'J')
map('', 'I', 'K')
map('', 'O', 'L')
map('', 'P', 'N')

-- Easymotion
map('n', 's', '<Plug>(easymotion-s2)', {noremap=false})
map('n', '/', '<Plug>(easymotion-sn)', {noremap=false})
map('o', '/', '<Plug>(easymotion-tn)', {noremap=false})
map('n', 'gl', '<Plug>(easymotion-overwin-line)', {noremap=false})
map('n', 'gw', '<Plug>(easymotion-bd-w)', {noremap=false})
map('n', 'ge', '<Plug>(easymotion-bd-e)', {noremap=false})
map('n', 'gf', '<Plug>(easymotion-lineforward)', {noremap=false})
map('n', 'gb', '<Plug>(easymotion-linebackward)', {noremap=false})
map('n', 'gn', '<Plug>(easymotion-j)', {noremap=false})
map('n', 'gi', '<Plug>(easymotion-k)', {noremap=false})

-- Easy-Align
map('x', 'ga', '<Plug>(EasyAlign)', {noremap=false})
map('n', 'ga', '<Plug>(EasyAlign)', {noremap=false})

-- Terminal
map('n', '<C-`>', ':FloatermToggle<CR>')
map('t', '<C-o>', '<C-\\><C-n>')
map('t', '<C-`>', '<C-\\><C-n>:FloatermToggle<CR>')
map('t', '<C-t>', '<C-\\><C-n>:FloatermNew<CR>')
map('t', '<C-q>', '<C-\\><C-n>:FloatermKill<CR>')
map('t', '<C-n>', '<C-\\><C-n>:FloatermNext<CR>')
map('t', '<C-p>', '<C-\\><C-n>:FloatermPrev<CR>')

-- LSP
map('n', '[e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_prev()<CR>')
map('n', ']e', '<cmd>lua require\'lspsaga.diagnostic\'.lsp_jump_diagnostic_next()<CR>')

-- Quick
map('n', '<leader><leader>', ':BufferLinePick<CR>')
map('n', '<leader><Tab>', ':e#<CR>')

-- Application
map('n', '<leader>aw', ':e ~/Documents/FALT_WIKI/README.md<CR>')
map('n', '<leader>aa', '<CMD>lua require(\'lspsaga.codeaction\').code_action()<CR>')

-- Edit
map('n', '<leader>et', ':%s/\s\+$//e<CR>')
map('n', '<leader>en', ':%d/^$/g<CR>')

-- Find and Search
map('n', '<leader>fa', ':LeaderfFile $HOME<CR>')
map('n', '<leader>ft', ':LeaderfBufTag<CR>')
map('n', '<leader>fh', ':Leaderf mru<CR>')
map('n', '<leader>fp', ':<C-R>=printf(\'Leaderf rg -e %s \', expand(\'<cword>\'))<CR><CR>')
map('n', '<leader>fw', ':<C-R>=printf(\'Leaderf rg -e \')<CR>')
map('n', '<leader>fl', '<CMD>lua require\'lspsaga.provider\'.lsp_finder()<CR>')

-- Paste
map('n', '<leader>pp', '"+p')
map('n', '<leader>pc', '":p')
map('n', '<leader>ps', '"/p')
map('n', '<leader>py', '"0p')

-- Goto
map('n', '<leader>gd', '<CMD>lua vim.lsp.buf.definition()<CR>')
map('n', '<leader>gi', '<CMD>lua vim.lsp.buf.implementation()<CR>')
map('n', '<leader>gr', '<CMD>lua vim.lsp.buf.references()<CR>')

-- Quit
map('n', '<leader>qq', ':Bd<CR><CR>')
map('n', '<leader>qw', ':qw<CR>')
map('n', '<leader>qa', ':qa<CR>')
map('n', '<leader>qx', ':qa!<CR>')

-- rename and format
map('n', '<leader>rn', '<CMD>lua require(\'lspsaga.rename\').rename()<CR>')
map('n', '<leader>rm', '<CMD>lua vim.lsp.buf.formatting()<CR>')

-- Mundo
map('n','<leader>u', ':MundoToggle<CR>')

-- open vimrc
map('n', '<leader>vo', ':e $MYVIMRC<CR>')

-- Tags
map('n', '<leader>t', ':Vista!!<CR>')

-- Windows Operate
map('n', '<leader>wh', '<C-w>s')
map('n', '<leader>wv', '<C-w>v')
map('n', '<leader>wq', '<C-w>c')
map('n', '<leader>wt', '<C-w>T')
map('n', '<leader>wy', '<C-w>h')
map('n', '<leader>wn', '<C-w>j')
map('n', '<leader>wi', '<C-w>k')
map('n', '<leader>wo', '<C-w>l')
map('n', '<leader>wY', '<C-w>H')
map('n', '<leader>wN', '<C-w>J')
map('n', '<leader>wI', '<C-w>K')
map('n', '<leader>wO', '<C-w>L')
map('n', '<leader>w+', '<C-w>+')
map('n', '<leader>w-', '<C-w>-')
map('n', '<leader>wc', ':only<CR>')

