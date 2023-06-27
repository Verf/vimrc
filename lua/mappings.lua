local keymap = vim.keymap

-- Norman Keyboard Layout
keymap.set({ 'n', 'o', 'x' }, 'd', 'e')
keymap.set({ 'n', 'o', 'x' }, 'f', 'r')
keymap.set({ 'n', 'o', 'x' }, 'k', 't')
keymap.set({ 'n', 'o', 'x' }, 'j', 'y')
keymap.set({ 'n', 'o', 'x' }, 'r', 'i')
keymap.set({ 'n', 'o', 'x' }, 'l', 'o')
keymap.set({ 'n', 'o', 'x' }, 'e', 'd')
keymap.set({ 'n', 'o', 'x' }, 't', 'f')
keymap.set({ 'n', 'o', 'x' }, 'y', 'h')
keymap.set({ 'n', 'o', 'x' }, 'n', 'j')
keymap.set({ 'n', 'o', 'x' }, 'i', 'k')
keymap.set({ 'n', 'o', 'x' }, 'o', 'l')
keymap.set({ 'n', 'o', 'x' }, 'p', 'n')
keymap.set({ 'n', 'o', 'x' }, 'h', ';')
keymap.set({ 'n', 'o', 'x' }, ';', 'p')
keymap.set({ 'n', 'o', 'x' }, 'D', 'E')
keymap.set({ 'n', 'o', 'x' }, 'F', 'R')
keymap.set({ 'n', 'o', 'x' }, 'K', 'T')
keymap.set({ 'n', 'o', 'x' }, 'J', 'Y')
keymap.set({ 'n', 'o', 'x' }, 'R', 'I')
keymap.set({ 'n', 'o', 'x' }, 'L', 'O')
keymap.set({ 'n', 'o', 'x' }, 'E', 'D')
keymap.set({ 'n', 'o', 'x' }, 'T', 'F')
keymap.set({ 'n', 'o', 'x' }, 'Y', 'H')
keymap.set({ 'n', 'o', 'x' }, 'N', 'J')
keymap.set({ 'n', 'o', 'x' }, 'I', 'K')
keymap.set({ 'n', 'o', 'x' }, 'O', 'L')
keymap.set({ 'n', 'o', 'x' }, 'P', 'N')
keymap.set({ 'n', 'o', 'x' }, 'H', ':')
keymap.set({ 'n', 'o', 'x' }, ':', 'P')

keymap.set('n', 'U', ':redo<CR>')
keymap.set('n', 'ee', _G.smart_dd, { noremap = true, expr = true })
keymap.set('x', '@', _G.visual_at, { noremap = true, expr = true })

keymap.set('n', '<TAB>', '<CMD>bn<CR>')
keymap.set('n', '<S-TAB>', '<CMD>bp<CR>')

keymap.set('n', 's', require('sj').run)

keymap.set('n', ']z', 'zj')
keymap.set('n', '[z', 'zk')

keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

keymap.set('n', '<C-s>', '#*cgn')
keymap.set('n', '<C-S-s>', '*#cgn')

keymap.set('i', '<C-a>', '<Esc>^i')
keymap.set('i', '<C-e>', '<Esc>$a')

keymap.set('n', ']d', '<CMD>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '[d', '<CMD>lua vim.diagnostic.goto_prev()<CR>')

keymap.set('n', 'gd', '<CMD>Telescope lsp_definitions<CR>')
keymap.set('n', 'gr', '<CMD>Telescope lsp_references<CR>')
keymap.set('n', 'gi', '<CMD>Telescope lsp_implementations<CR>')
keymap.set('n', 'gh', '<CMD>Telescope registers<CR>')

