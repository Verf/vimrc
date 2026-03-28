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

    vim.lsp.enable { 'ty', 'ruff', 'biome', 'rust_analyzer', 'gopls', 'zls', 'nushell' }

    kset({ 'n', 'x' }, '<leader>rn', [[<cmd> lua vim.lsp.buf.rename()<cr>]], { desc = 'Rename' })
    kset({ 'n', 'x' }, '<leader>ra', [[<cmd> lua vim.lsp.buf.code_action()<cr>]], { desc = 'Code Action' })
    kset({ 'n', 'x' }, '<leader>rh', [[<cmd> lua vim.lsp.buf.hover()<cr>]], { desc = 'Hover Doc' })

    _G.Config.new_autocmd('LspAttach', nil, function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end, 'Disable Semantic Tokens')
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
        'markdown',
        'markdown_inline',
        'html',
        'css',
        'yaml',
        'json',
        'latex',
        'nu',
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

later(
    function()
        vim.diagnostic.config {
            virtual_text = {
                source = 'always',
            },
            float = {
                source = 'always',
            },
            severity_sort = true,
        }
    end
)

later(function()
    add 'chrisgrieser/nvim-spider'

    kset({ 'n', 'o', 'x' }, 'w', [[<cmd>lua require('spider').motion('w')<cr>]])
    kset({ 'n', 'o', 'x' }, 'd', [[<cmd>lua require('spider').motion('e')<cr>]])
    kset({ 'n', 'o', 'x' }, 'b', [[<cmd>lua require('spider').motion('b')<cr>]])
end)

later(function()
    add 'stevearc/conform.nvim'

    require('conform').setup {
        default_format_opts = {
            lsp_format = 'fallback', -- 配置lsp的格式化器为默认项
        },
        format_after_save = {
            lsp_format = 'fallback',
        },

        formatters_by_ft = {
            python = { 'ruff_format', 'ruff_organize_imports' },
            lua = { 'stylua' },
            json = { 'biome' },
            nu = { 'nufmt' },
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
    add { source = 'saghen/blink.cmp', checkout = 'v1.10.1' }

    require('blink.cmp').setup {

        keymap = {
            preset = 'none',
            ['<cr>'] = { 'accept', 'fallback' },
            ['<C-e>'] = { 'hide', 'show' },
            ['<C-y>'] = { 'select_and_accept', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },

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
            trigger = {
                show_on_keyword = true,
                show_on_trigger_character = false,
            },
            menu = {
                draw = {
                    padding = { 0, 1 },
                    components = {
                        kind_icon = {
                            highlight = function(ctx)
                                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                    },
                },
            },
        },

        cmdline = {
            completion = {
                menu = { auto_show = true },
                list = { selection = { preselect = false, auto_insert = true } },
            },
        },
    }

    _G.Config.new_autocmd('InsertLeave', nil, function()
        vim.schedule(function() require('blink.cmp').cancel() end)
    end, 'Cancel completion when leave insert')
end)

later(function()
    local function build() require('fff.download').download_or_build_binary() end
    add {
        source = 'dmtrKovalenko/fff.nvim',
        hooks = {
            post_install = build,
            post_checkout = build,
        },
    }

    local file_picker = require 'fff.file_picker'
    if not file_picker.is_initialized() then
        local setup_success = file_picker.setup()
        if not setup_success then
            vim.notify('Could not setup fff.nvim', vim.log.levels.ERROR)
            return
        end
    end

    local state = {}

    -- 对路径进行标准化处理，去掉Windows下可能添加的前缀
    local function normalize_path(p)
        p = p or ''
        if vim.fn.has 'win32' == 1 and p:match '^\\\\%?\\' then return p:sub(5) end
        return p
    end

    local function find(query)
        query = query or ''
        local fff_result = file_picker.search_files(query, state.current_file_cache, 100, 4)

        local items = {}
        for _, fff_item in ipairs(fff_result) do
            local item = {
                text = normalize_path(fff_item.relative_path),
                path = normalize_path(fff_item.path),
            }
            table.insert(items, item)
        end
        return items
    end

    local function run()
        -- 仅当路径合法时进行缓存
        if not state.current_file_cache then
            local current_buf = vim.api.nvim_get_current_buf()
            if current_buf and vim.api.nvim_buf_is_valid(current_buf) and vim.api.nvim_buf_get_option(current_buf, 'buftype') == '' then -- 跳过 help/quickfix/etc.
                local current_file = vim.api.nvim_buf_get_name(current_buf)
                if current_file ~= '' and vim.fn.filereadable(current_file) == 1 then
                    local relative_path = vim.fs.relpath(vim.uv.cwd(), current_file)
                    state.current_file_cache = normalize_path(relative_path)
                end
            end
        end

        -- 使用mini.icons进行图标显示
        local function show_with_icons(buf_id, items, query) MiniPick.default_show(buf_id, items, query, { show_icons = true }) end

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

        vim.api.nvim_exec_autocmds('User', { pattern = 'MiniPickStop' })
        state.current_file_cache = nil
    end

    MiniPick.registry.fffiles = run

    kset('n', '<leader>ff', MiniPick.registry.fffiles, { desc = 'Find Files' })
end)

now_if_args(function() add 'MeanderingProgrammer/render-markdown.nvim' end)

later(function()
    add 'akinsho/toggleterm.nvim'

    require('toggleterm').setup {
        open_mapping = [[<C-\>]],
    }
end)

now_if_args(function()
    add 'Aasim-A/scrollEOF.nvim'

    require('scrollEOF').setup {
        pattern = '*',
        insert_mode = true,
    }
end)

now_if_args(function()
    add 'lewis6991/gitsigns.nvim'
    local gitsigns = require 'gitsigns'
    gitsigns.setup()

    kset('n', ']h', gitsigns.next_hunk, { desc = 'Next hunk' })
    kset('n', '[h', gitsigns.prev_hunk, { desc = 'Previous hunk' })

    kset('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
    kset('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset Hunk' })
    kset('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage Buffer' })
    kset('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset Buffer' })
    kset('n', '<leader>gb', gitsigns.blame_line, { desc = 'Show Blame Inline' })
    kset('n', '<leader>gB', gitsigns.blame, { desc = 'Show Blame' })
end)

now_if_args(function()
    add 'sindrets/diffview.nvim'

    local actions = require 'diffview.actions'
    require('diffview').setup {
        enhanced_diff_hl = true,
        keymaps = {
            disable_defaults = true,
            view = {
                { 'n', '<tab>', actions.select_next_entry, { desc = 'View next file' } },
                { 'n', '<S-tab>', actions.select_prev_entry, { desc = 'View previous File' } },
                { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
            },
            diff1 = {
                { 'n', 'g?', actions.help { 'view', 'diff1' }, { desc = 'Open the help panel' } },
                { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
            },
            diff2 = {
                { 'n', 'g?', actions.help { 'view', 'diff2' }, { desc = 'Open the help panel' } },
                { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
            },
            diff3 = {
                { { 'n', 'x' }, '2eo', actions.diffget 'ours', { desc = 'Obtain the diff hunk from the OURS version of the file' } },
                { { 'n', 'x' }, '3eo', actions.diffget 'theirs', { desc = 'Obtain the diff hunk from the THEIRS version of the file' } },
                { 'n', 'g?', actions.help { 'view', 'diff3' }, { desc = 'Open the help panel' } },
                { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
            },
            diff4 = {
                { { 'n', 'x' }, '1eo', actions.diffget 'base', { desc = 'Obtain the diff hunk from the BASE version of the file' } },
                { { 'n', 'x' }, '2eo', actions.diffget 'ours', { desc = 'Obtain the diff hunk from the OURS version of the file' } },
                { { 'n', 'x' }, '3eo', actions.diffget 'theirs', { desc = 'Obtain the diff hunk from the THEIRS version of the file' } },
                { 'n', 'g?', actions.help { 'view', 'diff4' }, { desc = 'Open the help panel' } },
                { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
            },
            file_panel = {
                { 'n', 'n', actions.next_entry, { desc = 'Next file entry' } },
                { 'n', 'i', actions.prev_entry, { desc = 'Previous file entry' } },
                { 'n', '<cr>', actions.select_entry, { desc = 'Select Entry' } },
                { 'n', 's', actions.toggle_stage_entry, { desc = 'Stage / unstage the selected entry' } },
                { 'n', 'S', actions.stage_all, { desc = 'Stage all entries' } },
                { 'n', 'U', actions.unstage_all, { desc = 'Unstage all entries' } },
                { 'n', 'X', actions.restore_entry, { desc = 'Restore entry' } },
                { 'n', 'L', actions.open_commit_log, { desc = 'Open commit log' } },
                { 'n', 'zo', actions.open_fold, { desc = 'Expand fold' } },
                { 'n', 'zc', actions.close_fold, { desc = 'Collapse fold' } },
                { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
                { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
                { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
                { 'n', '<C-d>', actions.scroll_view(0.25), { desc = 'Scroll the view down' } },
                { 'n', '<C-u>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
                { 'n', '<tab>', actions.select_next_entry, { desc = 'View next file' } },
                { 'n', '<S-tab>', actions.select_prev_entry, { desc = 'View previous file' } },
                { 'n', 'o', actions.goto_file_edit, { desc = 'Open file' } },
                { 'n', 'O', actions.goto_file_split, { desc = 'Open file split' } },
                { 'n', '.', actions.listing_style, { desc = 'Toggle view style' } },
                { 'n', 'F', actions.refresh_files, { desc = 'Update stats and entries in the file list' } },
                { 'n', '[x', actions.prev_conflict, { desc = 'Go to the previous conflict' } },
                { 'n', ']x', actions.next_conflict, { desc = 'Go to the next conflict' } },
                { 'n', 'g?', actions.help 'file_panel', { desc = 'Open the help panel' } },
                { 'n', '<leader>cO', actions.conflict_choose_all 'ours', { desc = 'Choose the OURS version of a conflict for the whole file' } },
                { 'n', '<leader>cT', actions.conflict_choose_all 'theirs', { desc = 'Choose the THEIRS version of a conflict for the whole file' } },
                { 'n', '<leader>cB', actions.conflict_choose_all 'base', { desc = 'Choose the BASE version of a conflict for the whole file' } },
                { 'n', '<leader>cA', actions.conflict_choose_all 'all', { desc = 'Choose all the versions of a conflict for the whole file' } },
                { 'n', 'eX', actions.conflict_choose_all 'none', { desc = 'Delete the conflict region for the whole file' } },
                { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
            },
            file_history_panel = {
                { 'n', 'g!', actions.options, { desc = 'Open the option panel' } },
                { 'n', 'gd', actions.open_in_diffview, { desc = 'Open the entry under the cursor in a diffview' } },
                { 'n', 'j', actions.copy_hash, { desc = 'Copy the commit hash of the entry under the cursor' } },
                { 'n', 'L', actions.open_commit_log, { desc = 'Show commit details' } },
                { 'n', 'X', actions.restore_entry, { desc = 'Restore file to the state from the selected entry' } },
                { 'n', 'zo', actions.open_fold, { desc = 'Expand fold' } },
                { 'n', 'zc', actions.close_fold, { desc = 'Collapse fold' } },
                { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
                { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
                { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
                { 'n', 'n', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
                { 'n', 'i', actions.prev_entry, { desc = 'Bring the cursor to the previous file entry' } },
                { 'n', '<cr>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
                { 'n', '<C-d>', actions.scroll_view(0.25), { desc = 'Scroll the view down' } },
                { 'n', '<C-u>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
                { 'n', '<tab>', actions.select_next_entry, { desc = 'Open the diff for the next file' } },
                { 'n', '<S-tab>', actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },
                { 'n', 'o', actions.goto_file_edit, { desc = 'Open the file in the previous tabpage' } },
                { 'n', 'O', actions.goto_file_split, { desc = 'Open the file in a new split' } },
                { 'n', 'g?', actions.help 'file_history_panel', { desc = 'Open the help panel' } },
                { 'n', 'q', [[<cmd>tabclose<cr>]], { desc = 'Quit diff view panel' } },
            },
            option_panel = {
                { 'n', '<tab>', actions.select_entry, { desc = 'Change the current option' } },
                { 'n', 'q', actions.close, { desc = 'Close the panel' } },
                { 'n', 'g?', actions.help 'option_panel', { desc = 'Open the help panel' } },
            },
            help_panel = {
                { 'n', 'q', actions.close, { desc = 'Close help menu' } },
                { 'n', '<esc>', actions.close, { desc = 'Close help menu' } },
            },
        },
    }

    kset('n', '<leader>gd', [[:DiffviewOpen ]], { desc = 'Diff View' })
    kset('n', '<leader>gh', [[<cmd>DiffviewFileHistory<cr>]], { desc = 'Diff File History' })
end)

now_if_args(function()
    add {
        source = 'kevinhwang91/nvim-ufo',
        depends = { 'kevinhwang91/promise-async' },
    }

    -- nvim-ufo 的自定义虚拟文本处理函数
    local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' ... 󰁂 %d lines '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
            else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if curWidth + chunkWidth < targetWidth then suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth) end
                break
            end
            curWidth = curWidth + chunkWidth
        end

        table.insert(newVirtText, { suffix, 'Comment' })
        return newVirtText
    end

    -- 执行配置
    require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype) return { 'treesitter', 'indent' } end,
        fold_virt_text_handler = handler,
    }

    kset('n', 'zR', require('ufo').openAllFolds, { desc = 'Open All Folds' })
    kset('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close All Folds' })
end)

now_if_args(function()
    add 'lukas-reineke/indent-blankline.nvim'
    require('ibl').setup()
end)
