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
        b = { '<CMD>Telescope buffers<CR>', 'buffers' },
        s = { '<CMD>Telescope session-lens search_session<CR>', 'sessions' },
        d = { '<CMD>Telescope diagnostics<CR>', 'diagnostics' },
        t = { '<CMD>TodoTelescope<CR>', 'todo' },
        n = {
            n = { [[<CMD>lua require('telekasten').find_notes()<CR>]], 'notes' },
            d = { [[<CMD>lua require('telekasten').find_daily_notes()<CR>]], 'dailies' },
        },
    },
    w = {
        name = '+window',
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
    q = {
        name = '+quit',
        a = { ':qa!<CR>', 'all' },
    },
    b = {
        name = '+buffer',
        b = { '<CMD>Telescope buffers<CR>', 'list' },
        q = { '<CMD>lua MiniBufremove.delete()<CR>', 'close' },
        c = { ':%bd|e#<CR>', 'only' },
        n = { ':vnew<CR>', 'new' },
    },
    t = {
        name = '+tab',
        n = { ':tabnew<CR>', 'new' },
        q = { ':tabclose<CR>', 'close' },
        c = { ':tabonly<CR>', 'only' },
    },
    r = {
        name = '+refact',
        n = { '<CMD>lua vim.lsp.buf.rename<CR>', 'rename' },
        s = { '<CMD>lua require("spectre").open()<CR>', 'spectre' },
    },
    n = {
        name = '+notes',
        n = { [[<CMD>lua require('telekasten').new_note()<CR>]], 'new note' },
        N = { [[<CMD>lua require('telekasten').new_templated_note()<CR>]], 'new templated note' },
        d = { [[<CMD>lua require('telekasten').goto_today()<CR>]], 'today' },
        w = { [[<CMD>lua require('telekasten').goto_thisweek()<CR>]], 'thisweek' },
        r = { [[<CMD>lua require('telekasten').rename_note()<CR>]], 'rename' },
        t = { [[<CMD>lua require('telekasten').toggle_todo()<CR>]], 'toggle todo' },
        ['#'] = { [[<CMD>lua require('telekasten').show_tags()<CR>]], 'tags' },
    },
    ['<SPACE>'] = { '<CMD>BufferLinePick<CR>', 'pick buffer' },
    m = { '<CMD>Format<CR>', 'format' },
}, { prefix = '<leader>' })
