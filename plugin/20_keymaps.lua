local kset = vim.keymap.set

-- Norman Keyboard Layout
kset({ 'n', 'o', 'x' }, 'd', 'e')
kset({ 'n', 'o', 'x' }, 'f', 'r')
kset({ 'n', 'o', 'x' }, 'k', 't')
kset({ 'n', 'o', 'x' }, 'j', 'y')
kset({ 'n', 'o', 'x' }, 'r', 'i')
kset({ 'n', 'o', 'x' }, 'l', 'o')
kset({ 'n', 'o', 'x' }, 'e', 'd')
kset({ 'n', 'o', 'x' }, 't', 'f')
kset({ 'n', 'o', 'x' }, 'y', 'h')
kset({ 'n', 'o', 'x' }, 'n', 'j')
kset({ 'n', 'o', 'x' }, 'i', 'k')
kset({ 'n', 'o', 'x' }, 'o', 'l')
kset({ 'n', 'o', 'x' }, 'p', 'n')
kset({ 'n', 'o', 'x' }, 'h', ';')
kset({ 'n', 'o', 'x' }, ';', 'p')
kset({ 'n', 'o', 'x' }, 'D', 'E')
kset({ 'n', 'o', 'x' }, 'F', 'R')
kset({ 'n', 'o', 'x' }, 'K', 'T')
kset({ 'n', 'o', 'x' }, 'J', 'Y')
kset({ 'n', 'o', 'x' }, 'R', 'I')
kset({ 'n', 'o', 'x' }, 'L', 'O')
kset({ 'n', 'o', 'x' }, 'E', 'D')
kset({ 'n', 'o', 'x' }, 'T', 'F')
kset({ 'n', 'o', 'x' }, 'Y', 'H')
kset({ 'n', 'o', 'x' }, 'N', 'J')
kset({ 'n', 'o', 'x' }, 'I', 'K')
kset({ 'n', 'o', 'x' }, 'O', 'L')
kset({ 'n', 'o', 'x' }, 'P', 'N')
kset({ 'n', 'o', 'x' }, 'H', ':')
kset({ 'n', 'o', 'x' }, ':', 'P')

kset('n', '<TAB>', '<CMD>bn<CR>')
kset('n', '<S-TAB>', '<CMD>bp<CR>')
kset('n', '<leader><TAB>', '<CMD>b#<CR>', { desc = 'Swith Buffer' })

kset('n', 'zn', 'zj')
kset('n', 'zi', 'zk')

kset({ 'n', 'o', 'x' }, 'gs', '^', { desc = 'Goto Line Start' })
kset({ 'n', 'o', 'x' }, 'gl', '$', { desc = 'Goto Line End' })

kset({ 'n', 'v' }, '<leader>j', '"*y', { desc = ' Copy to System Clipboard' })
kset({ 'n', 'v' }, '<leader>;', '"*p', { desc = ' Paste from System Clipboard' })

kset('n', '<leader>qa', '<CMD>wqa!<CR>', { desc = 'Quit All' })
kset('n', '<leader>qq', '<CMD>bd!<CR>', { desc = 'Buffer Close' })

kset('n', '<leader>bc', '<CMD>%bd!|e#<CR>', { desc = 'Buffer Only' })

kset('n', '<leader>tn', '<CMD>tabnew<CR>', { desc = 'Tab New' })
kset('n', '<leader>tq', '<CMD>tabclose<CR>', { desc = 'Tab Close' })
kset('n', '<leader>tc', '<CMD>tabonly<CR>', { desc = 'Tab Only' })

kset('n', '<leader>wc', '<C-w>o', { desc = 'Window Only' })
kset('n', '<leader>wq', '<C-w>c', { desc = 'Window Close' })
kset('n', '<leader>ws', '<C-w>s', { desc = 'Window Split' })
kset('n', '<leader>wv', '<C-w>v', { desc = 'Window VSplit' })
kset('n', '<leader>wy', '<C-w>h', { desc = 'Switch to Left' })
kset('n', '<leader>wn', '<C-w>j', { desc = 'Switch to Bottom' })
kset('n', '<leader>wi', '<C-w>k', { desc = 'Switch to Up' })
kset('n', '<leader>wo', '<C-w>l', { desc = 'Switch to Right' })
kset('n', '<leader>wY', '<C-w>H', { desc = 'Window to Left' })
kset('n', '<leader>wN', '<C-w>J', { desc = 'Window to Bottom' })
kset('n', '<leader>wI', '<C-w>K', { desc = 'Window to Up' })
kset('n', '<leader>wO', '<C-w>L', { desc = 'Window to Right' })

-- 删除的空行不记录寄存器中
kset('n', 'ee', function()
    if vim.api.nvim_get_current_line():match '^%s*$' then
        return '"_dd'
    else
        return 'dd'
    end
end, { expr = true })

-- 修改时不记录寄存器中
kset({ 'n', 'v' }, 'c', '"_c')
kset({ 'n', 'v' }, 'C', '"_C')
kset({ 'n', 'v' }, 'x', '"_x')

-- 替换并记录当前内容，支持按.自动替换下一个
kset('n', '<C-s>', 'g*Ncgn', { desc = 'Search & Replace' })
kset('x', '<C-s>', function()
    -- 1. 复制当前选区内容到寄存器 v
    vim.cmd 'noau normal! "vy'
    -- 2. 获取内容并转义特殊字符
    local text = vim.fn.getreg 'v'
    local escaped_text = '\\V' .. vim.fn.escape(text, '\\/')
    -- 3. 将其设置为搜索寄存器 /
    vim.fn.setreg('/', escaped_text)
    -- 4. 使用 feedkeys 发送后续按键
    local keys = vim.api.nvim_replace_termcodes('<Esc>cgn', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
end, { desc = 'Search & Replace' })

kset('n', '@', function()
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
end, { expr = true, desc = 'Execute Macro' })
kset('n', 'Q', function()
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
end, { expr = true, desc = 'Execute Last Macro' })
