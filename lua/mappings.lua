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
-- switch keymap for marks and registers
keymap.set({ 'n', 'o', 'x' }, [[']], [["]])
keymap.set({ 'n', 'o', 'x' }, [["]], [[']])

-- don't push to clipboard when delete empty line
keymap.set('n', 'ee', function()
    if vim.api.nvim_get_current_line():match '^%s*$' then
        return '"_dd'
    else
        return 'dd'
    end
end, { noremap = true, expr = true })

-- don't add change value to clipboard
keymap.set({ 'n', 'v' }, 'c', '"_c')
keymap.set({ 'n', 'v' }, 'C', '"_C')
keymap.set({ 'n', 'v' }, 's', '"_s')
keymap.set({ 'n', 'v' }, 'S', '"_S')

-- speed up macro running
keymap.set('n', '@', function()
    local count = vim.v.count1
    local register = vim.fn.getcharstr()
    vim.opt.lazyredraw = true
    vim.opt.eventignore = { 'TextChanged', 'TextChangedI' }
    vim.opt.clipboard = ''
    vim.api.nvim_command(string.format('norm! %d@%s', count, register))
    vim.opt.lazyredraw = false
    vim.opt.eventignore = ''
    vim.opt.clipboard = 'unnamedplus'
    vim.api.nvim_command 'silent update'
end, { noremap = true })
keymap.set('n', 'Q', function()
    local count = vim.v.count1
    vim.opt.lazyredraw = true
    vim.opt.eventignore = { 'TextChanged', 'TextChangedI' }
    vim.opt.clipboard = ''
    vim.api.nvim_command(string.format('norm! %dQ', count))
    vim.opt.lazyredraw = false
    vim.opt.eventignore = ''
    vim.opt.clipboard = 'unnamedplus'
    vim.api.nvim_command 'silent update'
end, { noremap = true })

keymap.set('n', '<TAB>', '<CMD>bn<CR>')
keymap.set('n', '<S-TAB>', '<CMD>bp<CR>')
keymap.set('n', '<leader><TAB>', '<CMD>b#<CR>')

keymap.set('n', ']z', 'zj')
keymap.set('n', '[z', 'zk')

keymap.set('n', '<C-s>', '#*cgn')
keymap.set('v', '<C-s>', [[y/\V<C-R>=escape(@",'/\')<CR><CR>Ncgn]])

keymap.set('n', '<leader>qa', '<CMD>qa!<CR>')

keymap.set('n', '<leader>bc', '<CMD>%bd!|e#<CR>')
keymap.set('n', '<leader>bq', '<CMD>bd!<CR>')
keymap.set('n', '<leader>bn', '<CMD>vnew<CR>')

keymap.set('n', '<leader>tn', '<CMD>tabnew<CR>')
keymap.set('n', '<leader>tq', '<CMD>tabclose<CR>')
keymap.set('n', '<leader>tc', '<CMD>tabonly<CR>')

keymap.set('n', '<leader>wc', '<C-w>o')
keymap.set('n', '<leader>wq', '<C-w>c')
keymap.set('n', '<leader>wY', '<C-w>H')
keymap.set('n', '<leader>wN', '<C-w>J')
keymap.set('n', '<leader>wI', '<C-w>K')
keymap.set('n', '<leader>wO', '<C-w>L')

keymap.set({ 'n', 'v', 'i' }, '<F1>', '<CMD>vs | term<CR>')
keymap.set('t', '<Esc>', '<C-\\><C-n>')