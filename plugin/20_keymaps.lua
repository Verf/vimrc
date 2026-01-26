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

-- don't push to clipboard when delete empty line
keymap.set('n', 'ee', function()
    if vim.api.nvim_get_current_line():match '^%s*$' then
        return '"_dd'
    else
        return 'dd'
    end
end, { expr = true })

-- don't add change value to clipboard
keymap.set({ 'n', 'v' }, 'c', '"_c')
keymap.set({ 'n', 'v' }, 'C', '"_C')

keymap.set('n', '<TAB>', '<CMD>bn<CR>')
keymap.set('n', '<S-TAB>', '<CMD>bp<CR>')
keymap.set('n', '<leader><TAB>', '<CMD>b#<CR>', { desc = 'Swith Buffer' })

keymap.set('n', 'zn', 'zj')
keymap.set('n', 'zi', 'zk')

keymap.set('n', '<C-s>', '*``cgn', { desc = 'Search & Replace' })
keymap.set('v', '<C-s>', [[y/\V<C-R>=escape(@",'/\')<CR><CR>Ncgn]], { desc = 'Search & Replace' })

keymap.set({ 'n', 'o', 'x' }, 'gs', '^', { desc = 'Goto Line Start' })
keymap.set({ 'n', 'o', 'x' }, 'gl', '$', { desc = 'Goto Line End' })

keymap.set({ 'n', 'v' }, '<leader>j', '"*y', { desc = ' Copy to System Clipboard' })
keymap.set({ 'n', 'v' }, '<leader>;', '"*p', { desc = ' Paste from System Clipboard' })

keymap.set('n', '<leader>qa', '<CMD>wqa!<CR>', { desc = 'Quit All' })
keymap.set('n', '<leader>qq', '<CMD>bd!<CR>', { desc = 'Buffer Close' })

keymap.set('n', '<leader>bc', '<CMD>%bd!|e#<CR>', { desc = 'Buffer Only' })

keymap.set('n', '<leader>tn', '<CMD>tabnew<CR>', { desc = 'Tab New' })
keymap.set('n', '<leader>tq', '<CMD>tabclose<CR>', { desc = 'Tab Close' })
keymap.set('n', '<leader>tc', '<CMD>tabonly<CR>', { desc = 'Tab Only' })

keymap.set('n', '<leader>wc', '<C-w>o', { desc = 'Window Only' })
keymap.set('n', '<leader>wq', '<C-w>c', { desc = 'Window Close' })
keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Window Split' })
keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Window VSplit' })
keymap.set('n', '<leader>wy', '<C-w>h', { desc = 'Switch to Left' })
keymap.set('n', '<leader>wn', '<C-w>j', { desc = 'Switch to Bottom' })
keymap.set('n', '<leader>wi', '<C-w>k', { desc = 'Switch to Up' })
keymap.set('n', '<leader>wo', '<C-w>l', { desc = 'Switch to Right' })
keymap.set('n', '<leader>wY', '<C-w>H', { desc = 'Window to Left' })
keymap.set('n', '<leader>wN', '<C-w>J', { desc = 'Window to Bottom' })
keymap.set('n', '<leader>wI', '<C-w>K', { desc = 'Window to Up' })
keymap.set('n', '<leader>wO', '<C-w>L', { desc = 'Window to Right' })
