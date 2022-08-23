local wk = require 'which-key'
wk.setup {
    key_labels = {
        ['<space>'] = 'SPC',
        ['<cr>'] = 'RET',
        ['<tab>'] = 'TAB',
    },
    presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
    },
}
-- disable presets
local presets = require 'which-key.plugins.presets'
presets.operators = {}

wk.register({
    f = {
        name = '+find',
        f = { '<CMD>Telescope find_files<CR>', 'files' },
        h = { '<CMD>Telescope oldfiles<CR>', 'history' },
        e = { '<CMD>Telescope everything<CR>', 'everything' },
        g = { '<CMD>Telescope live_grep<CR>', 'grep' },
        b = { '<CMD>Telescope buffers<CR>', 'buffer' },
        s = { '<CMD>Telescope possession list<CR>', 'session' },
        t = { '<CMD>TodoTelescope<CR>', 'todo' },
    },
    w = {
        name = '+window',
        c = { '<C-w>o', 'only' },
        q = { '<C-w>c', 'close' },
        h = { '<C-w>s', 'split horizontal' },
        v = { '<C-w>v', 'split vertical' },
        y = { '<C-w>h', 'jump left' },
        n = { '<C-w>j', 'jump bottom' },
        i = { '<C-w>k', 'jump up' },
        o = { '<C-w>l', 'jump right' },
        Y = { '<C-w>H', 'move left' },
        N = { '<C-w>J', 'move bottom' },
        I = { '<C-w>K', 'move up' },
        O = { '<C-w>L', 'move right' },
        ['+'] = { '<C-w>+', 'increase' },
        ['-'] = { '<C-w>-', 'decrease' },
        ['='] = { '<C-w>=', 'equal' },
    },
    q = {
        name = '+quit',
        a = { ':qa!<CR>', 'all' },
        q = { '<CMD>lua MiniBufremove.delete()<CR>', 'current' },
        c = { ':w|%bd!|e#|bd#<CR><CR>', 'only' },
    },
    b = {
        name = '+buffer',
        d = { ':bd!<CR>', 'close' },
        c = { ':w|%bd!|e#|bd#<CR><CR>', 'only' },
        n = { ':enew<CR>', 'new' },
    },
    r = {
        name = '+refact',
        n = { '<CMD>lua vim.lsp.buf.rename()<CR>', 'rename' },
        s = { '<CMD>lua require("spectre").open()<CR>', 'spectre' },
    },
    ['<SPACE>'] = { '<CMD>BufferLinePick<CR>', 'pick buffer' },
    m = { '<CMD>Format<CR>', 'format' },
}, { prefix = '<leader>' })
