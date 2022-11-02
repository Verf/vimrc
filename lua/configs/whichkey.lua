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
    ['<SPACE>'] = { '<CMD>BufferLinePick<CR>', 'pick buffer' },
    ['1'] = { '<CMD>lua require("bufferline").go_to_buffer(1, true)<CR>', 'goto buffer 1' },
    ['2'] = { '<CMD>lua require("bufferline").go_to_buffer(2, true)<CR>', 'goto buffer 2' },
    ['3'] = { '<CMD>lua require("bufferline").go_to_buffer(3, true)<CR>', 'goto buffer 3' },
    ['4'] = { '<CMD>lua require("bufferline").go_to_buffer(4, true)<CR>', 'goto buffer 4' },
    ['5'] = { '<CMD>lua require("bufferline").go_to_buffer(5, true)<CR>', 'goto buffer 5' },
    ['6'] = { '<CMD>lua require("bufferline").go_to_buffer(6, true)<CR>', 'goto buffer 6' },
    ['7'] = { '<CMD>lua require("bufferline").go_to_buffer(7, true)<CR>', 'goto buffer 7' },
    ['8'] = { '<CMD>lua require("bufferline").go_to_buffer(8, true)<CR>', 'goto buffer 8' },
    ['9'] = { '<CMD>lua require("bufferline").go_to_buffer(9, true)<CR>', 'goto buffer 9' },
    f = {
        name = '+find',
        f = { '<CMD>Telescope find_files<CR>', 'files' },
        h = { '<CMD>Telescope oldfiles<CR>', 'history' },
        e = { '<CMD>Telescope everything<CR>', 'everything' },
        g = { '<CMD>Telescope live_grep<CR>', 'grep' },
        b = { '<CMD>Telescope buffers<CR>', 'buffers' },
        d = { '<CMD>Telescope diagnostics<CR>', 'diagnostics' },
        t = { '<CMD>TodoTelescope<CR>', 'todo' },
        s = { '<CMD>Telescope lsp_document_symbols<CR>', 'symbols' },
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
        q = { '<CMD>lua MiniBufremove.delete(0, true)<CR>', 'current' },
    },
    b = {
        name = '+buffer',
        q = { ':bd!<CR>', 'close' },
        c = { ':%bd!|e#<CR>', 'only' },
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
    m = { '<CMD>Format<CR>', 'format' },
}, { prefix = '<leader>' })
