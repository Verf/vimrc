local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local now_if_args = _G.Config.now_if_args
local kset = vim.keymap.set

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

later(function() require('mini.align').setup() end)
later(function() require('mini.diff').setup() end)
later(function() require('mini.extra').setup() end)
later(function() require('mini.git').setup() end)
later(function() require('mini.trailspace').setup() end)
later(function() require('mini.pairs').setup() end)

later(function() require('mini.operators').setup { replace = { prefix = '' } } end)

later(function()
    require('mini.bufremove').setup()

    kset('n', '<leader>qq', '<CMD>lua MiniBufremove.delete(0, true)<CR>', { desc = 'Buffer Close' })
end)

later(
    function()
        require('mini.bracketed').setup {
            buffer = { suffix = '', options = {} },
            comment = { suffix = '', options = {} },
            conflict = { suffix = 'x', options = {} },
            diagnostic = { suffix = 'd', options = { severity = vim.diagnostic.severity.ERROR } },
            file = { suffix = '', options = {} },
            indent = { suffix = '', options = {} },
            jump = { suffix = '', options = {} },
            location = { suffix = '', options = {} },
            oldfile = { suffix = '', options = {} },
            quickfix = { suffix = 'q', options = {} },
            treesitter = { suffix = '', options = {} },
            undo = { suffix = 'u', options = {} },
            window = { suffix = '', options = {} },
            yank = { suffix = '', options = {} },
        }
    end
)

later(function()
    require('mini.indentscope').setup {
        mappings = {
            -- 禁用textobject
            object_scope = '',
            object_scope_with_border = '',
        },
    }
end)

later(
    function()
        require('mini.surround').setup {
            mappings = {
                add = '<leader>sa',
                delete = '<leader>se',
                find = '<leader>st',
                find_left = '<leader>sT',
                highlight = '<leader>sh',
                replace = '<leader>sc',

                suffix_last = 'l',
                suffix_next = 'n',
            },
        }
    end
)

later(function()
    local mini_pick = require 'mini.pick'
    mini_pick.setup {
        options = {
            use_cache = true,
        },
    }
    -- 定义一个智能选择器函数用于加速文件搜索
    -- 在插件加载时预检查工具存在情况
    local has_fd = vim.fn.executable 'fd' == 1
    local has_rg = vim.fn.executable 'rg' == 1
    -- 定义一个缓存表，key 是当前工作目录，value 是该目录下最佳的工具
    local tool_cache = {}
    mini_pick.registry.files = function(local_opts, opts)
        local_opts = local_opts or {}
        opts = opts or {}
        -- 1. 获取当前工作目录 (CWD)
        local cwd = vim.fn.getcwd()
        -- 2. 如果用户没指定工具，且缓存里没有记录，则进行检测
        if not local_opts.tool then
            if not tool_cache[cwd] then
                -- A. 检查是否在 git 项目中 (利用 vim.fs 高效向上查找)
                -- limit=1 表示只要找到一个就停止，path=cwd 指定从当前目录开始
                local git_root = vim.fs.find('.git', { path = cwd, upward = true, limit = 1 })[1]
                if git_root then
                    tool_cache[cwd] = 'git'
                -- B. 只有非 Git 项目才去检查 fd 或 rg
                elseif has_fd then
                    tool_cache[cwd] = 'fd'
                elseif has_rg then
                    tool_cache[cwd] = 'rg'
                else
                    -- 如果都没有，留空让 mini.pick 使用默认回退
                    tool_cache[cwd] = 'fallback'
                end
            end
            -- 3. 从缓存应用工具 (如果缓存是 'fallback' 则不设置 tool 字段)
            if tool_cache[cwd] ~= 'fallback' then local_opts.tool = tool_cache[cwd] end
        end
        return mini_pick.builtin.files(local_opts, opts)
    end

    kset('n', '<leader>ff', [[<CMD>Pick files<CR>]], { desc = 'Find Files' })
    kset('n', '<leader>fh', [[<CMD>Pick oldfiles<CR>]], { desc = 'Find Files' })
    kset('n', '<leader>fs', [[<CMD>Pick lsp scope="document_symbol"<CR>]], { desc = 'Find Symbols' })
    kset('n', '<leader>fd', [[<CMD>Pick diagnostic scope="current"<CR>]], { desc = 'Diagnostic' })
    kset('n', '<leader>fD', [[<CMD>Pick diagnostic scope="all"<CR>]], { desc = 'Diagnostic All' })
    kset('n', '<leader>fg', [[<CMD>Pick grep_live<CR>]], { desc = 'Live Grep' })
    kset('n', '<leader>fw', [[<CMD>Pick grep pattern="<cword>"<CR>]], { desc = 'Grep CWord' })

    -- 当LspAttach时设置快捷键，避免冲突
    _G.Config.new_autocmd('LspAttach', nil, function(args)
        kset('n', 'gd', [[<CMD>Pick lsp scope="definition"<CR>]], { desc = 'Goto Definition' })
        kset('n', 'gr', [[<CMD>Pick lsp scope="references"<CR>]], { desc = 'Goto References' })
        kset('n', 'gD', [[<CMD>Pick lsp scope="declaration"<CR>]], { desc = 'Goto Declaration' })
        kset('n', 'gD', function() vim.lsp.buf.hover() end, { desc = 'Goto Declaration' })
    end, 'Set lsp keymaps')
end)

later(
    function()
        require('mini.jump').setup {
            mappings = {
                forward = 't',
                backward = 'T',
                forward_till = 'k',
                backward_till = 'K',
                repeat_jump = '',
            },
        }
    end
)

later(function()
    require('mini.jump2d').setup {
        view = {
            dim = true,
            n_steps_ahead = 2,
        },
        mappings = {
            start_jumping = '',
        },
    }

    kset('n', 'gw', [[<CMD>lua MiniJump2d.start(MiniJump2d.builtin_opts.word_start)<CR>]], {})
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
    MiniKeymap.map_multistep(
        'i',
        '<Tab>',
        { 'minisnippets_next', 'minisnippets_expand', 'blink_next', 'jump_after_close' }
    )
    MiniKeymap.map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'blink_prev', 'jump_before_open' })
    -- <CR> 用于选择补全项或应用mini.pairs
    MiniKeymap.map_multistep('i', '<CR>', { 'blink_accept', 'minipairs_cr' })
    -- <BS> 用于消除mini.pairs
    MiniKeymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

later(function()
    local snippets = require 'mini.snippets'
    local config_path = vim.fn.stdpath 'config'
    snippets.setup {
        snippets = {
            snippets.gen_loader.from_file(config_path .. '/snippets/global.json'),
            snippets.gen_loader.from_lang { lang_patterns = { markdown_inline = { 'markdown.json' } } },
        },
        mappings = {
            expand = '',
            jump_next = '<C-d>',
            jump_prev = '<C-u>',
            stop = '<C-c>',
        },
    }

    -- 开启一个简单的lsp服务使snippets在补全菜单可见
    -- MiniSnippets.start_lsp_server()
end)

later(function()
    local miniclue = require 'mini.clue'
    local leader_group_clues = {
        { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
        { mode = 'n', keys = '<Leader>f', desc = '+Find' },
        { mode = 'n', keys = '<Leader>q', desc = '+Quit' },
        { mode = 'n', keys = '<Leader>r', desc = '+Lsp' },
        { mode = 'n', keys = '<Leader>s', desc = '+Surround' },
        { mode = 'n', keys = '<Leader>t', desc = '+Tab' },
        { mode = 'n', keys = '<Leader>w', desc = '+Window' },
    }
    miniclue.setup {
        clues = {
            leader_group_clues,
            -- miniclue.gen_clues.builtin_completion(),
            -- miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            -- miniclue.gen_clues.square_brackets(),
            -- miniclue.gen_clues.z(),
        },
        -- Explicitly opt-in for set of common keys to trigger clue window
        triggers = {
            { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
            -- { mode = 'n', keys = '\\' }, -- mini.basics
            -- { mode = { 'n', 'x' }, keys = '[' }, -- mini.bracketed
            -- { mode = { 'n', 'x' }, keys = ']' },
            -- { mode = 'i', keys = '<C-x>' }, -- Built-in completion
            -- { mode = { 'n', 'x' }, keys = 'g' }, -- `g` key
            { mode = { 'n', 'x' }, keys = "'" }, -- Marks
            { mode = { 'n', 'x' }, keys = '`' }, -- Marks
            { mode = { 'n', 'x' }, keys = '"' }, -- Registers
            { mode = { 'i', 'c' }, keys = '<C-r>' },
            -- { mode = { 'n', 'x' }, keys = 's' }, -- `s` key (mini.surround, etc.)
            -- { mode = { 'n', 'x' }, keys = 'z' }, -- `z` key
        },
    }
end)

later(function()
    require('mini.files').setup {
        mappings = {
            close = 'q',
            go_in = 'o',
            go_in_plus = 'O',
            go_out = 'y',
            go_out_plus = 'Y',
            mark_goto = "'",
            mark_set = 'm',
            reset = '<BS>',
            reveal_cwd = '@',
            show_help = 'g?',
            synchronize = '=',
            trim_left = '<',
            trim_right = '>',
        },
    }

    kset('n', '-', [[<CMD>lua MiniFiles.open()<CR>]], { desc = 'Open Files' })
end)
