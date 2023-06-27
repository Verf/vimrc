local g = vim.g
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
    ['<TAB>'] = { '<CMD>b#<CR>', 'Last buffer' },
    ['<SPACE>'] = { '<CMD>Telescope buffers<CR>', 'Find buffer' },
    b = {
        name = '+Buffer',
        b = { '<CMD>Telescope buffers<CR>', 'list' },
        c = { ':%bd!|e#<CR>', 'only' },
        q = { ':bd!<CR>', 'close' },
        n = { ':vnew<CR>', 'new' },
    },
    f = {
        name = '+Find',
        f = { '<CMD>Telescope find_files<CR>', 'files' },
        h = { '<CMD>Telescope oldfiles<CR>', 'history' },
        e = { '<CMD>Telescope everything<CR>', 'everything' },
        g = { '<CMD>Telescope live_grep<CR>', 'grep' },
        d = { '<CMD>Telescope diagnostics<CR>', 'diagnostics' },
        s = { '<CMD>Telescope lsp_document_symbols<CR>', 'symbols' },
    },
    m = { '<CMD>FormatLock<CR>', 'format' },
    n = {
        name = '+Notes',
        d = { ':e ' .. g.diary_directory .. '\\' .. os.date '%Y-%m-%d' .. '.md<CR>', 'diary' },
        n = { ':e ' .. g.notes_directory .. '\\', 'notes' },
        f = { '<CMD>cd ' .. g.notes_directory .. ' | Telescope find_files<CR>', 'find' },
    },
    q = {
        name = '+Quit',
        a = { ':qa!<CR>', 'all' },
        q = { '<CMD>lua MiniBufremove.delete(0, true)<CR>', 'current' },
    },
    r = {
        name = '+Refact',
        n = { '<CMD>lua vim.lsp.buf.rename()<CR>', 'rename' },
        l = { _G.recompile, 'reload' },
    },
    t = {
        name = '+Tab',
        n = { ':tabnew<CR>', 'new' },
        q = { ':tabclose<CR>', 'close' },
        c = { ':tabonly<CR>', 'only' },
    },
    w = {
        name = '+Window',
        c = { '<C-w>o', 'only' },
        q = { '<C-w>c', 'close' },
        -- ['+'] = { '<C-w>+', 'increase' },
        -- ['-'] = { '<C-w>-', 'decrease' },
        -- ['='] = { '<C-w>=', 'equal' },
        -- h = { '<C-w>s', 'split horizontal' },
        -- v = { '<C-w>v', 'split vertical' },
        -- y = { '<C-w>h', 'jump left' },
        -- n = { '<C-w>j', 'jump bottom' },
        -- i = { '<C-w>k', 'jump up' },
        -- o = { '<C-w>l', 'jump right' },
        Y = { '<C-w>H', 'move left' },
        N = { '<C-w>J', 'move bottom' },
        I = { '<C-w>K', 'move up' },
        O = { '<C-w>L', 'move right' },
        y = { '<CMD>FocusSplitLeft<CR>', 'focus left' },
        n = { '<CMD>FocusSplitDown<CR>', 'focus down' },
        i = { '<CMD>FocusSplitUp<CR>', 'focus up' },
        o = { '<CMD>FocusSplitRight<CR>', 'focus right' },
    },
}, { prefix = '<leader>' })
