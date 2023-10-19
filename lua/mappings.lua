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
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype ~= '' then
        vim.api.nvim_command 'silent update'
    end
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
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' and vim.bo.buftype ~= '' then
        vim.api.nvim_command 'silent update'
    end
end, { noremap = true })

keymap.set('n', '<TAB>', '<CMD>bn<CR>')
keymap.set('n', '<S-TAB>', '<CMD>bp<CR>')
keymap.set('n', '<leader><TAB>', '<CMD>b#<CR>', { desc = 'Swith Buffer' })

keymap.set('n', ']d', ':lua vim.diagnostic.goto_next()<CR>', { desc = 'Next diagnostic' })
keymap.set('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>', { desc = 'Previous diagnostic' })

keymap.set('n', 'zn', 'zj')
keymap.set('n', 'zi', 'zk')

keymap.set('n', '<C-s>', '*``cgn', { desc = 'Search & Replace' })
keymap.set('v', '<C-s>', [[y/\V<C-R>=escape(@",'/\')<CR><CR>Ncgn]], { desc = 'Search & Replace' })

keymap.set('n', '<leader>qa', '<CMD>qa!<CR>', { desc = 'Quit All' })

keymap.set('n', '<leader>bc', '<CMD>%bd!|e#<CR>', { desc = 'Buffer Only' })
keymap.set('n', '<leader>bq', '<CMD>bd!<CR>', { desc = 'Buffer Close' })
keymap.set('n', '<leader>bn', '<CMD>vnew<CR>', { desc = 'Buffer New' })

keymap.set('n', '<leader>tn', '<CMD>tabnew<CR>', { desc = 'Tab New' })
keymap.set('n', '<leader>tq', '<CMD>tabclose<CR>', { desc = 'Tab Close' })
keymap.set('n', '<leader>tc', '<CMD>tabonly<CR>', { desc = 'Tab Only' })

keymap.set('n', '<leader>wc', '<C-w>o', { desc = 'Window Only' })
keymap.set('n', '<leader>wq', '<C-w>c', { desc = 'Window Close' })
keymap.set('n', '<leader>wY', '<C-w>H', { desc = 'Window to Left' })
keymap.set('n', '<leader>wN', '<C-w>J', { desc = 'Window to Bottom' })
keymap.set('n', '<leader>wI', '<C-w>K', { desc = 'Window to Up' })
keymap.set('n', '<leader>wO', '<C-w>L', { desc = 'Window to Right' })

keymap.set({ 'n', 'v', 'i' }, '<F1>', '<CMD>vs | term<CR>', { desc = 'Open Terminal' })
keymap.set('t', '<Esc>', '<C-\\><C-n>')
