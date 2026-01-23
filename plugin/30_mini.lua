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
later(function()
    require('mini.pick').setup()

    vim.keymap.set('n', '<leader>ff', [[<CMD>Pick files<CR>]], { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fs', [[<CMD>Pick lsp scope="document_symbol"<CR>]], { desc = 'Find Symbols' })
    vim.keymap.set('n', '<leader>fd', [[<CMD>Pick diagnostic scope="current"<CR>]], { desc = 'Diagnostic' })
    vim.keymap.set('n', '<leader>fD', [[<CMD>Pick diagnostic scope="all"<CR>]], { desc = 'Diagnostic All' })
    vim.keymap.set('n', '<leader>fg', [[<CMD>Pick grep_live<CR>]], { desc = 'Live Grep' })
    vim.keymap.set('n', '<leader>fw', [[<CMD>Pick grep pattern="<cword>"<CR>]], { desc = 'Grep CWord' })
end)

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
later(function()
    require('mini.keymap').setup()
    -- 使用 <Tab>/<S-Tab> 选择补全菜单项
    MiniKeymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
    MiniKeymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
    -- <CR> 用于选择补全项或应用mini.pairs
    MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
    -- <BS> 用于消除mini.pairs
    MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

later(function()
    -- 对LSP补全结果后处理，隐藏Text，并调整Snippet到列表末尾
    local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
    local process_items = function(items, base)
        return MiniCompletion.default_process_items(items, base, process_items_opts)
    end
    require('mini.completion').setup {
        lsp_completion = {
            -- 1. 使用omnifunc而不是默认的completefunc
            -- 2. 关闭LSP自动配置，用于下面的on_attach
            -- 3. 应用上面的后处理规则
            source_func = 'omnifunc',
            auto_setup = false,
            process_items = process_items,
        },
    }

    -- 当LspAttach时挂载omnifunc为MiniCompletion.completefunc_lsp
    local on_attach = function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end
    _G.Config.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")

    -- 向LSP服务器告知客户端能力
    vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)

later(function()
    local snippets = require 'mini.snippets'
    local config_path = vim.fn.stdpath 'config'
    snippets.setup {
        snippets = {
            snippets.gen_loader.from_file(config_path .. '/snippets/global.json'),
        },
    }
end)
