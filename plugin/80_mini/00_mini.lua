vim.pack.add {
    'https://github.com/echasnovski/mini.nvim',
}

local misc = require 'mini.misc'
_G.Config.now = function(f) misc.safely('now', f) end
_G.Config.later = function(f) misc.safely('later', f) end
_G.Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
_G.Config.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
_G.Config.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end
