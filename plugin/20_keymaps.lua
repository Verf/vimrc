-- [[ Norman Keyboard Layout ]]
vim.keymap.set({ 'n', 'o', 'x' }, 'd', 'e')
vim.keymap.set({ 'n', 'o', 'x' }, 'f', 'r')
vim.keymap.set({ 'n', 'o', 'x' }, 'k', 't')
vim.keymap.set({ 'n', 'o', 'x' }, 'j', 'y')
vim.keymap.set({ 'n', 'o', 'x' }, 'r', 'i')
vim.keymap.set({ 'n', 'o', 'x' }, 'l', 'o')
vim.keymap.set({ 'n', 'o', 'x' }, 'e', 'd')
vim.keymap.set({ 'n', 'o', 'x' }, 't', 'f')
vim.keymap.set({ 'n', 'o', 'x' }, 'y', 'h')
vim.keymap.set({ 'n', 'o', 'x' }, 'n', 'j')
vim.keymap.set({ 'n', 'o', 'x' }, 'i', 'k')
vim.keymap.set({ 'n', 'o', 'x' }, 'o', 'l')
vim.keymap.set({ 'n', 'o', 'x' }, 'p', 'n')
vim.keymap.set({ 'n', 'o', 'x' }, 'h', ';')
vim.keymap.set({ 'n', 'o', 'x' }, ';', 'p')
vim.keymap.set({ 'n', 'o', 'x' }, 'D', 'E')
vim.keymap.set({ 'n', 'o', 'x' }, 'F', 'R')
vim.keymap.set({ 'n', 'o', 'x' }, 'K', 'T')
vim.keymap.set({ 'n', 'o', 'x' }, 'J', 'Y')
vim.keymap.set({ 'n', 'o', 'x' }, 'R', 'I')
vim.keymap.set({ 'n', 'o', 'x' }, 'L', 'O')
vim.keymap.set({ 'n', 'o', 'x' }, 'E', 'D')
vim.keymap.set({ 'n', 'o', 'x' }, 'T', 'F')
vim.keymap.set({ 'n', 'o', 'x' }, 'Y', 'H')
vim.keymap.set({ 'n', 'o', 'x' }, 'N', 'J')
vim.keymap.set({ 'n', 'o', 'x' }, 'I', 'K')
vim.keymap.set({ 'n', 'o', 'x' }, 'O', 'L')
vim.keymap.set({ 'n', 'o', 'x' }, 'P', 'N')
vim.keymap.set({ 'n', 'o', 'x' }, 'H', ':')
vim.keymap.set({ 'n', 'o', 'x' }, ':', 'P')

-- [[ Edit ]]
-- 全局模糊搜索
vim.keymap.set('n', '<leader>/', ':Grep ', { desc = 'Grep' })
-- 修改时不记录寄存器中
vim.keymap.set({ 'n', 'v' }, 'c', '"_c')
vim.keymap.set({ 'n', 'v' }, 'C', '"_C')

-- 替换并记录当前内容，支持按.自动替换下一个
vim.keymap.set('n', '<C-s>', 'g*Ncgn', { desc = 'Search & Replace' })
vim.keymap.set('x', '<C-s>', function()
    -- 1. 复制当前选区内容到寄存器 v
    vim.cmd 'noau normal! "vy'
    -- 2. 获取内容并转义特殊字符
    local text = vim.fn.getreg 'v'
    local escaped_text = '\\V' .. vim.fn.escape(text, '\\/')
    -- 3. 将其设置为搜索寄存器 /
    vim.fn.setreg('/', escaped_text)
    -- 4. 使用 feedkeys 发送后续按键
    local keys = vim.api.nvim_replace_termcodes('<esc>cgn', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', false)
end, { desc = 'Search & Replace' })

-- 删除的空行不记录寄存器中
vim.keymap.set('n', 'ee', function()
    -- 获取将要删除的行数（如果没有输入数字如 3ee，则默认为 1）
    local count = vim.v.count1
    -- 获取当前光标所在的行号 (Neovim API 行号从 0 开始，所以要减 1)
    local start_row = vim.api.nvim_win_get_cursor(0)[1] - 1
    -- 获取将要删除的所有行内容
    local lines = vim.api.nvim_buf_get_lines(0, start_row, start_row + count, false)
    -- 遍历所有即将被删除的行
    for _, line in ipairs(lines) do
        -- 只要发现有任何一行包含了“非空白字符”
        if not line:match '^%s*$' then
            -- 就正常删除，记录到寄存器中
            return 'dd'
        end
    end
    -- 否则不记录
    return '"_dd'
end, { expr = true })

-- [[ Copy & Paste]]
vim.keymap.set({ 'n', 'v' }, '<leader>j', '"*y', { desc = 'System Copy' })
vim.keymap.set({ 'n', 'v' }, '<leader>;', '"*p', { desc = 'System Paste' })

-- [[ Buffer ]]

vim.keymap.set({ 'n', 'x' }, '<tab>', '<cmd>bn<cr>', { desc = 'Next Buffer' })
vim.keymap.set({ 'n', 'x' }, '<s-tab>', '<cmd>bp<cr>', { desc = 'Previous Buffer' })
vim.keymap.set({ 'n', 'x' }, '<leader><tab>', '<cmd>b#<cr>', { desc = 'Swith Buffer' })
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>', { desc = 'Write Quite' })
vim.keymap.set({ 'n', 'x' }, '<leader>X', function()
    local current_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf == current_buf or not vim.bo[buf].buflisted then goto continue end
        if vim.bo[buf].modified then
            local name = vim.api.nvim_buf_get_name(buf)
            if name ~= '' then
                vim.api.nvim_buf_call(buf, function() vim.cmd 'silent! update' end)
            end
            if vim.bo[buf].modified then goto continue end
        end
        vim.api.nvim_buf_delete(buf, { force = true })
        ::continue::
    end
end, { desc = 'Buffer Only' })

-- [[ Tab ]]
vim.keymap.set('n', '<leader>tN', '<cmd>tabnew<cr>', { desc = 'Tab New' })
vim.keymap.set('n', '<leader>tq', '<cmd>tabclose<cr>', { desc = 'Tab Close' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabonly<cr>', { desc = 'Tab Only' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabnext<cr>', { desc = 'Tab Next' })
vim.keymap.set('n', '<leader>t<tab>', '<cmd>tabnext<cr>', { desc = 'Tab Next' })
vim.keymap.set('n', '<leader>tp', '<cmd>tabprevious<cr>', { desc = 'Tab Previous' })

-- [[ Window ]]
local function smart_win_move(dir)
    local cur_win = vim.api.nvim_get_current_win()
    vim.cmd('wincmd ' .. dir) -- 先尝试切换

    -- 如果窗口没变（说明那个方向没有窗口）
    if cur_win == vim.api.nvim_get_current_win() then
        if dir == 'h' then
            vim.cmd 'leftabove vsplit' -- 左边新建
        elseif dir == 'l' then
            vim.cmd 'vsplit' -- 右边新建（默认就是右边）
        elseif dir == 'j' then
            vim.cmd 'split' -- 下边新建（默认就是下面）
        elseif dir == 'k' then
            vim.cmd 'leftabove split' -- 上边新建
        end
        vim.cmd('wincmd ' .. dir) -- 再次切换
    end
end
vim.keymap.set('n', '<leader>wc', '<C-w>o', { desc = 'Window Only' })
vim.keymap.set('n', '<leader>wq', '<C-w>c', { desc = 'Window Close' })
vim.keymap.set('n', '<leader>ws', '<C-w>s', { desc = 'Window Split' })
vim.keymap.set('n', '<leader>wv', '<C-w>v', { desc = 'Window VSplit' })
vim.keymap.set('n', '<leader>wy', function() smart_win_move 'h' end, { desc = 'Switch to Left' })
vim.keymap.set('n', '<leader>wn', function() smart_win_move 'j' end, { desc = 'Switch to Bottom' })
vim.keymap.set('n', '<leader>wi', function() smart_win_move 'k' end, { desc = 'Switch to Up' })
vim.keymap.set('n', '<leader>wo', function() smart_win_move 'l' end, { desc = 'Switch to Right' })
vim.keymap.set('n', '<leader>wY', '<C-w>H', { desc = 'Window to Left' })
vim.keymap.set('n', '<leader>wN', '<C-w>J', { desc = 'Window to Bottom' })
vim.keymap.set('n', '<leader>wI', '<C-w>K', { desc = 'Window to Up' })
vim.keymap.set('n', '<leader>wO', '<C-w>L', { desc = 'Window to Right' })

for i = 1, 4 do
    local lhs = '<leader>' .. i
    local rhs = i .. '<C-w>w'
    vim.keymap.set('n', lhs, rhs, { desc = 'Move to Window ' .. i })
end

-- [[ Fold ]]
vim.keymap.set('n', 'zn', 'zj')
vim.keymap.set('n', 'zi', 'zk')

-- [[ Terminal ]]
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
-- 竖向分屏打开 terminal
vim.keymap.set('n', '<leader>tv', function() vim.cmd 'vsplit | terminal' end, { desc = 'Vertical split Terminal' })
-- 水平分屏打开 terminal
vim.keymap.set('n', '<leader>th', function() vim.cmd 'split | terminal' end, { desc = 'Horizontal split Terminal' })

-- [[ Diagnostic ]]
vim.keymap.set('n', '<leader>wd', vim.diagnostic.open_float, { desc = 'Show diagnostics under the cursor' })
vim.keymap.set('n', '<leader>ul', function() vim.opt.list = not vim.opt.list:get() end, { desc = 'Toggle listchars' })

-- [[ Insert ]]
vim.keymap.set(
    'n',
    '<leader>id',
    function() vim.api.nvim_put({ os.date '%Y-%m-%d' }, 'c', true, true) end,
    { desc = 'Insert Date' }
)
vim.keymap.set(
    'n',
    '<leader>it',
    function() vim.api.nvim_put({ os.date '%Y-%m-%d %H:%M:%S' }, 'c', true, true) end,
    { desc = 'Insert Datetime' }
)

-- [[ Others ]]
-- 删除内置的增量选择快捷键
pcall(vim.keymap.del, { 'x', 'o' }, 'in')
