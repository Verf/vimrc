local now, later, add = MiniDeps.now, MiniDeps.later, MiniDeps.add
local now_if_args = _G.Config.now_if_args
local kset = vim.keymap.set

now(function()
    add { source = 'Verf/deepwhite.nvim', checkout = 'dev' }

    require('deepwhite').setup {
        low_blue_light = true,
    }

    vim.cmd 'color deepwhite'
end)

now_if_args(function()
    add 'neovim/nvim-lspconfig'

    vim.lsp.enable { 'ty', 'ruff', 'biome', 'rust_analyzer', 'gopls' }

    kset({ 'n', 'x' }, '<leader>rn', [[<CMD> lua vim.lsp.buf.rename()<CR>]], { desc = 'Rename' })
    kset({ 'n', 'x' }, '<leader>ra', [[<CMD> lua vim.lsp.buf.code_action()<CR>]], { desc = 'Code Action' })
    kset({ 'n', 'x' }, '<leader>rh', [[<CMD> lua vim.lsp.buf.hover()<CR>]], { desc = 'Hover Doc' })
end)

now_if_args(function()
    add {
        source = 'nvim-treesitter/nvim-treesitter',
        hooks = { post_checkout = function() vim.cmd 'TSUpdate' end },
    }
    add {
        source = 'nvim-treesitter/nvim-treesitter-textobjects',
        checkout = 'main',
    }

    local languages = {
        'python',
        'javascript',
        'typescript',
        'vue',
    }
    local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0 end
    local to_install = vim.tbl_filter(isnt_installed, languages)
    if #to_install > 0 then require('nvim-treesitter').install(to_install) end

    -- 打开文件时启动TreeSitter
    local filetypes = {}
    for _, lang in ipairs(languages) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
            table.insert(filetypes, ft)
        end
    end
    local ts_start = function(ev) vim.treesitter.start(ev.buf) end
    _G.Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')

    -- treesitter-textobject按键设置
    -- select
    local ts_select = require 'nvim-treesitter-textobjects.select'
    kset({ 'x', 'o' }, 'af', function() ts_select.select_textobject('@function.outer', 'textobjects') end)
    kset({ 'x', 'o' }, 'rf', function() ts_select.select_textobject('@function.inner', 'textobjects') end)
    kset({ 'x', 'o' }, 'ac', function() ts_select.select_textobject('@class.outer', 'textobjects') end)
    kset({ 'x', 'o' }, 'rc', function() ts_select.select_textobject('@class.inner', 'textobjects') end)
    kset({ 'x', 'o' }, 'as', function() ts_select.select_textobject('@local.scope', 'locals') end)
    -- move
    local ts_move = require 'nvim-treesitter-textobjects.move'
    kset({ 'n', 'x', 'o' }, ']f', function() ts_move.goto_next_start('@function.outer', 'textobjects') end)
    kset({ 'n', 'x', 'o' }, ']c', function() ts_move.goto_next_start('@class.outer', 'textobjects') end)
    kset({ 'n', 'x', 'o' }, '[f', function() ts_move.goto_previous_start('@function.outer', 'textobjects') end)
    kset({ 'n', 'x', 'o' }, '[c', function() ts_move.goto_previous_start('@class.outer', 'textobjects') end)
end)

later(function() vim.diagnostic.config { virtual_text = true, severity_sort = true } end)

later(function()
    add 'chrisgrieser/nvim-spider'

    kset({ 'n', 'o', 'x' }, 'w', [[<CMD>lua require('spider').motion('w')<CR>]])
    kset({ 'n', 'o', 'x' }, 'd', [[<CMD>lua require('spider').motion('e')<CR>]])
    kset({ 'n', 'o', 'x' }, 'b', [[<CMD>lua require('spider').motion('b')<CR>]])
end)

later(function()
    add 'stevearc/conform.nvim'

    require('conform').setup {
        default_format_opts = {
            lsp_format = 'fallback', -- 配置lsp的格式化器为默认项
        },
        format_on_save = {
            timeout_ms = 1000,
        },

        formatters_by_ft = {
            lua = { 'stylua' },
            json = { 'biome' },
            javascript = { 'dprint' },
            typescript = { 'dprint' },
            vue = { 'dprint' },
        },
    }
end)

later(function()
    add { source = 'jake-stewart/multicursor.nvim', checkout = '1.0' }
    local mc = require 'multicursor-nvim'
    mc.setup()

    -- 类似于helix的多光标快捷键
    -- s: 在选中范围内按正则拆分
    kset('v', 's', mc.matchCursors, { desc = 'Add cursor by regex' })
    -- Alt-s: 按换行符拆分
    kset('v', '<M-s>', function() mc.splitCursors '^' end, { desc = 'Split on newlines' })

    -- 定义多光标状态下的快捷键
    mc.addKeymapLayer(function(layerSet)
        -- 选择前/后光标作为主光标
        layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
        layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)
        -- 使用上下键添加或减少行光标
        layerSet({ 'n', 'x' }, '<up>', function() mc.lineAddCursor(-1) end)
        layerSet({ 'n', 'x' }, '<down>', function() mc.lineAddCursor(1) end)
        -- 删除主光标
        layerSet({ 'n', 'x' }, '<M-,>', mc.deleteCursor)
        -- 删除主光标外的其他光标
        layerSet({ 'n', 'x' }, ',', function()
            if mc.hasCursors() then mc.clearCursors() end
        end, { desc = 'Clear all cursors' })
    end)
end)

later(function()
    add { source = 'saghen/blink.cmp', checkout = 'v1.9.1' }

    require('blink.cmp').setup {

        keymap = { preset = 'none' },

        appearance = {
            nerd_font_variant = 'mono',
        },

        snippets = { preset = 'mini_snippets' },

        sources = {
            default = { 'lsp', 'buffer', 'path' },
        },

        signature = { enabled = true },

        fuzzy = { implementation = 'prefer_rust_with_warning' },

        completion = {
            list = { selection = { preselect = false, auto_insert = true } },
        },

        cmdline = {
            completion = {
                menu = { auto_show = true },
                list = { selection = { preselect = false, auto_insert = true } },
            },
        },
    }
end)

later(function()
    local function build_fff(args) require('fff.download').download_or_build_binary() end
    add {
        source = 'dmtrKovalenko/fff.nvim',
        hooks = {
            post_install = build_fff,
            post_checkout = build_fff,
        },
    }

    -- from https://github.com/nvim-mini/mini.nvim/discussions/1974
    local state = {}
    local ns_id = vim.api.nvim_create_namespace 'MiniPick FFFiles Picker'

    local function find(query)
        local file_picker = require 'fff.file_picker'

        query = query or ''
        local fff_result = file_picker.search_files(query, state.current_file_cache, 100, 4)

        local items = {}
        for _, fff_item in ipairs(fff_result) do
            local item = {
                text = fff_item.relative_path,
                path = fff_item.path,
            }
            table.insert(items, item)
        end

        return items
    end

    local function run()
        -- Setup fff.nvim
        local file_picker = require 'fff.file_picker'
        if not file_picker.is_initialized() then
            local setup_success = file_picker.setup()
            if not setup_success then
                vim.notify('Could not setup fff.nvim', vim.log.levels.ERROR)
                return
            end
        end

        -- Cache current file to deprioritize in fff.nvim
        if not state.current_file_cache then
            local current_buf = vim.api.nvim_get_current_buf()
            if current_buf and vim.api.nvim_buf_is_valid(current_buf) then
                local current_file = vim.api.nvim_buf_get_name(current_buf)
                if current_file ~= '' and vim.fn.filereadable(current_file) == 1 then
                    local relative_path = vim.fs.relpath(vim.uv.cwd(), current_file)
                    state.current_file_cache = relative_path
                else
                    state.current_file_cache = nil
                end
            end
        end

        local function show_with_icons(buf_id, items, query)
            MiniPick.default_show(buf_id, items, query, { show_icons = true })
        end

        -- Start picker
        MiniPick.start {
            source = {
                name = 'FFFiles',
                items = find,
                match = function(_, _, query)
                    local items = find(table.concat(query))
                    MiniPick.set_picker_items(items, { do_match = false })
                end,
                show = show_with_icons,
            },
        }

        state.current_file_cache = nil -- Reset cache
    end

    MiniPick.registry.fffiles = run

    kset('n', '<leader>ff', MiniPick.registry.fffiles)
end)
