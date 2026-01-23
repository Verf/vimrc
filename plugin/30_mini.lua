local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local now_if_args = _G.Config.now_if_args

now(function() vim.cmd 'colorscheme miniwinter' end)

now(function()
    -- Set up to not prefer extension-based icon for some extensions
    local ext3_blocklist = { scm = true, txt = true, yml = true }
    local ext4_blocklist = { json = true, yaml = true }
    require('mini.icons').setup {
        use_file_extension = function(ext, _) return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)]) end,
    }

    -- 模拟nvim-web-devicons以兼容不支持mini.icons的插件
    later(MiniIcons.mock_nvim_web_devicons)
    -- 为LSP kind添加icons
    later(MiniIcons.tweak_lsp_kind)
end)

now_if_args(function()
    require('mini.misc').setup()

    MiniMisc.setup_auto_root()
    MiniMisc.setup_restore_cursor()
end)

now(function() require('mini.notify').setup() end)
now(function() require('mini.statusline').setup() end)
now(function() require('mini.tabline').setup() end)

later(function() require('mini.extra').setup() end)
later(function() require('mini.align').setup() end)
later(function() require('mini.bracketed').setup() end)
later(function() require('mini.bufremove').setup() end)
later(function() require('mini.cmdline').setup() end)
later(function() require('mini.diff').setup() end)
later(function() require('mini.indentscope').setup() end)
later(function() require('mini.git').setup() end)
later(function() require('mini.pairs').setup { modes = { command = true } } end)
later(function() require('mini.surround').setup() end)
later(function() require('mini.trailspace').setup() end)

later(
    function()
        require('mini.jump').setup {
            mappings = {
                forward = 't',
                backward = 'T',
                forward_till = 'k',
                backward_till = 'K',
                repeat_jump = ',',
            },
        }
    end
)

later(function()
    require('mini.jump2d').setup {
        mappings = {
            start_jumping = '',
        },
    }

    vim.keymap.set('n', 'gw', [[<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>]], {})
end)

later(
    function()
        require('mini.move').setup {
            mappings = {
                left = '<M-y>',
                right = '<M-o>',
                down = '<M-n>',
                up = '<M-i>',
                line_left = '<M-y>',
                line_right = '<M-o>',
                line_down = '<M-n>',
                line_up = '<M-i>',
            },
        }
    end
)

later(function()
    local hipatterns = require 'mini.hipatterns'
    local hi_words = MiniExtra.gen_highlighter.words
    hipatterns.setup {
        highlighters = {
            fixme = hi_words({ 'FIXME' }, 'MiniHipatternsFixme'),
            hack = hi_words({ 'HACK' }, 'MiniHipatternsHack'),
            todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
            note = hi_words({ 'NOTE' }, 'MiniHipatternsNote'),
            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    }
end)
