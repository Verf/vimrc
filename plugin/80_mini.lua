-- =============================================================================
-- mini.nvim - All-in-one install + per-module configuration
-- =============================================================================

vim.pack.add({
  'https://github.com/echasnovski/mini.nvim',
})

-- =============================================================================
-- mini.ai
-- =============================================================================
local spec_treesitter = require('mini.ai').gen_spec.treesitter
require('mini.ai').setup({
  mappings = {
    inside = 'r',
    inside_next = '',
    inside_last = '',
  },
  custom_textobjects = {
    d = { '%f[%d]%d+' },
    s = {
      {
        '%u[%l%d]+%f[^%l%d]',
        '%f[%S][%l%d]+%f[^%l%d]',
        '%f[%P][%l%d]+%f[^%l%d]',
        '^[%l%d]+%f[^%l%d]',
      },
      '^().*()$',
    },
    c = spec_treesitter({ a = '@class.outer', i = '@class.inner' }),
    f = spec_treesitter({ a = '@function.outer', i = '@function.inner' }),
  },
})

-- mini.ai接管r映射后无法fallback到原始的定义，因此重新映射
vim.keymap.set({ 'x', 'o' }, 'rw', 'iw')
vim.keymap.set({ 'x', 'o' }, 'rW', 'iW')

-- =============================================================================
-- mini.align
-- =============================================================================
require('mini.align').setup({})

-- =============================================================================
-- mini.bufremove
-- =============================================================================
require('mini.bufremove').setup({})

vim.keymap.set({ 'n', 'x' }, '<leader>x', function()
  require('mini.bufremove').delete(0, true)
end, { desc = 'Close Buffer' })

-- =============================================================================
-- mini.cmdline
-- =============================================================================
require('mini.cmdline').setup({ delay = 10 })

-- =============================================================================
-- mini.comment
-- =============================================================================
require('mini.comment').setup({})

-- =============================================================================
-- mini.diff
-- =============================================================================
require('mini.diff').setup({ view = { style = 'number' } })

-- =============================================================================
-- mini.extra
-- =============================================================================
require('mini.extra').setup({})

vim.keymap.set('n', '<leader>h', function()
  MiniExtra.pickers.oldfiles()
end, { desc = 'Oldfiles' })

vim.keymap.set('n', '<leader>z', function()
  MiniExtra.pickers.visit_paths({
    filter = function(data)
      return vim.fn.isdirectory(data.path) == 1
    end,
    cwd = '', -- 默认限制在cwd范围，设置cwd = ''可查询全局
  }, {
    source = {
      name = 'Visits',
      choose = function(item)
        if item == nil then
          return
        end
        local full_path = vim.fn.fnamemodify(item, ':p')
        vim.api.nvim_set_current_dir(full_path)
        vim.notify('cd ' .. full_path, vim.log.levels.INFO)
      end,
    },
  })
end, { desc = 'Visit Directories' })

vim.keymap.set('n', '<leader>d', function()
  MiniExtra.pickers.diagnostic({ scope = 'current' })
end, { desc = 'Diagnostics' })

vim.keymap.set('n', '<leader>s', function()
  MiniExtra.pickers.lsp({ scope = 'document_symbol' })
end, { desc = 'Symbols' })

-- git
vim.keymap.set('n', '<leader>gb', function()
  MiniExtra.pickers.git_branches({ scope = 'local' })
end, { desc = 'Find Git Branches' })

vim.keymap.set('n', '<leader>gfs', function()
  MiniExtra.pickers.git_hunks({ path = '%', scope = 'staged' })
end, { desc = 'Find Staged' })

vim.keymap.set('n', '<leader>gfS', function()
  MiniExtra.pickers.git_hunks({ scope = 'staged' })
end, { desc = 'Find All Staged' })

vim.keymap.set('n', '<leader>gfu', function()
  MiniExtra.pickers.git_hunks({ path = '%', scope = 'unstaged' })
end, { desc = 'Find Unstaged' })

vim.keymap.set('n', '<leader>gfU', function()
  MiniExtra.pickers.git_hunks({ scope = 'unstaged' })
end, { desc = 'Find All Unstaged' })

-- lsp
vim.keymap.set('n', 'grr', function()
  MiniExtra.pickers.lsp({ scope = 'references' })
end, { desc = 'Goto references' })

vim.keymap.set('n', 'gri', function()
  MiniExtra.pickers.lsp({ scope = 'implementation' })
end, { desc = 'Goto implementation' })

vim.keymap.set('n', 'grt', function()
  MiniExtra.pickers.lsp({ scope = 'type_definition' })
end, { desc = 'Goto type_definition' })

-- =============================================================================
-- mini.git
-- =============================================================================
require('mini.git').setup({})

vim.keymap.set({ 'n', 'x' }, '<leader>gs', function()
  require('mini.git').show_at_cursor()
end, { desc = 'Show' })

-- =============================================================================
-- mini.hipatterns
-- =============================================================================
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

-- =============================================================================
-- mini.icons
-- =============================================================================
require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

-- =============================================================================
-- mini.jump
-- =============================================================================
require('mini.jump').setup({
  mappings = {
    forward = 't',
    backward = 'T',
    forward_till = 'k',
    backward_till = 'K',
    repeat_jump = 'h',
  },
})

-- =============================================================================
-- mini.jump2d
-- =============================================================================
require('mini.jump2d').setup({
  -- mini.jump2d永远以labels中字母的顺序，按屏幕从上到下，从左到右的顺序为spot标记label。
  -- 根据实际体验+/-10行左右位置是最为常见进行跳转使用的位置，因此考虑设置这里为最常用按键
  -- 同时对于qzkjbp这几个比较难以按到的键位，不安排到labels中
  labels = 'gaxcwdtesfvoinulrmhy',
  view = { dim = true, n_steps_ahead = 99 },
  allowed_windows = { not_current = false },
  mappings = { start_jumping = '' },
})

vim.keymap.set({ 'n', 'x', 'o' }, 'gw', function()
  MiniJump2d.start({ spotter = MiniJump2d.gen_spotter.pattern('%f[%w]%w+') })
end, { desc = 'Goto words' })

vim.keymap.set({ 'n', 'x', 'o' }, 'gs', function()
  MiniJump2d.start({ spotter = MiniJump2d.gen_spotter.pattern('%p+') })
end, { desc = 'Goto symbols' })

vim.keymap.set({ 'n', 'x', 'o' }, 'gl', function()
  MiniJump2d.start(MiniJump2d.builtin_opts.line_start)
end, { desc = 'Goto lines' })

vim.keymap.set({ 'n', 'x', 'o' }, ',', function()
  MiniJump2d.start(MiniJump2d.builtin_opts.single_character)
end, { desc = 'Goto Single Character' })

-- =============================================================================
-- mini.keymap
-- =============================================================================
require('mini.keymap').setup({})

local map_multistep = require('mini.keymap').map_multistep
map_multistep('i', '<Tab>', { 'minisnippets_expand', 'blink_next' })
map_multistep('i', '<S-Tab>', { 'minisnippets_prev', 'blink_prev' })
map_multistep('i', '<C-d>', { 'minisnippets_next', 'jump_after_close' })
map_multistep('i', '<C-u>', { 'minisnippets_prev', 'jump_before_open' })
map_multistep('i', '<CR>', { 'blink_accept', 'minipairs_cr' })
map_multistep('i', '<BS>', { 'minipairs_bs' })

-- =============================================================================
-- mini.misc
-- =============================================================================
require('mini.misc').setup()
require('mini.misc').setup_auto_root()
require('mini.misc').setup_restore_cursor()

-- =============================================================================
-- mini.move
-- =============================================================================
require('mini.move').setup({
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
})

-- =============================================================================
-- mini.notify
-- =============================================================================
require('mini.notify').setup({})

-- =============================================================================
-- mini.operators
-- =============================================================================
require('mini.operators').setup({
  -- g= gx gm gf
  sort = { prefix = '' },
  replace = { prefix = 'gf' },
})

-- =============================================================================
-- mini.pairs
-- =============================================================================
require('mini.pairs').setup({})

-- =============================================================================
-- mini.pick
-- =============================================================================
require('mini.pick').setup({
  options = { use_cache = true },
  mappings = {
    choose_marked = '<C-q>',
  },
})

vim.keymap.set('n', '<leader>f', function()
  MiniPick.builtin.files()
end, { desc = 'Files' })

vim.keymap.set('n', '<leader>b', function()
  MiniPick.builtin.buffers()
end, { desc = 'Buffers' })

vim.keymap.set('n', '<leader>/', function()
  MiniPick.builtin.grep_live()
end, { desc = 'Grep Live' })

-- for orgmode.nvim
vim.keymap.set('n', '<leader>of', function()
  MiniPick.builtin.files({}, { source = { cwd = vim.fn.expand(vim.env.NOTE_TAKING_DIR) } })
end, { desc = 'Find Notes' })

-- =============================================================================
-- mini.sessions
-- =============================================================================
require('mini.sessions').setup({
  autowrite = true,
  file = '',
  hooks = {
    pre = {
      write = function()
        -- 清理无用的空 buffer
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if
            vim.api.nvim_buf_get_name(bufnr) == ''
            and vim.api.nvim_buf_get_option(bufnr, 'buftype') == ''
          then
            pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
          end
        end
      end,
    },
    post = {
      read = function()
        -- 避免Lsp或语法高亮在加载session后可能未正常激活
        vim.cmd('doautoall BufReadPost')
      end,
    },
  },
})

vim.keymap.set('n', '<leader>Ss', function()
  require('mini.sessions').select()
end, { desc = 'Select Session' })

vim.keymap.set('n', '<leader>Sw', function()
  local name = vim.fn.input('Session name: ')
  if name ~= '' then
    require('mini.sessions').write(name)
  end
end, { desc = 'Write Session' })

vim.keymap.set('n', '<leader>Sd', function()
  local name = vim.fn.input('Session name: ')
  if name ~= '' then
    require('mini.sessions').delete(name)
  end
end, { desc = 'Delete Session' })

-- =============================================================================
-- mini.snippets
-- =============================================================================
local snippets = require('mini.snippets')
snippets.setup({
  snippets = {
    snippets.gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/global.json'),
    snippets.gen_loader.from_lang({ lang_patterns = { markdown_inline = { 'markdown.json' } } }),
  },
  mappings = { expand = '', jump_next = '', jump_prev = '', stop = '<C-c>' },
  expand = {
    match = function(snips)
      -- 确保仅会在精确匹配prefix时展开snippet
      return snippets.default_match(snips, {
        pattern_exact_boundary = '[^%w_]?',
        pattern_fuzzy = '',
      })
    end,
  },
})

-- 退出Insert模式时自动停止snippet状态
vim.api.nvim_create_autocmd('InsertLeave', {
  group = _G.my_group,
  callback = function()
    if snippets.session.get() then
      vim.schedule(function()
        while snippets.session.get() do
          snippets.session.stop()
        end
      end)
    end
  end,
})

-- =============================================================================
-- mini.splitjoin
-- =============================================================================
require('mini.splitjoin').setup({})

-- =============================================================================
-- mini.statusline
-- =============================================================================
local stsl = require('mini.statusline')
stsl.setup({
  content = {
    inactive = function()
      -- 1. 获取当前正在渲染状态栏的真实 Window ID
      -- Neovim 在渲染非当前窗口状态栏时，会将其 ID 存放在 vim.g.statusline_winid 中
      local winid = vim.g.statusline_winid or vim.api.nvim_get_current_win()
      -- 2. 将 Window ID 转换为方便人类跳转的 Window Number (1, 2, 3...)
      local winnr = vim.api.nvim_win_get_number(winid)
      -- 3. 获取文件路径（使用 mini.statusline 默认的文件名组件）
      local filename = MiniStatusline.section_filename({ trunc_width = 140 })
      -- 4. 组合并返回状态栏内容
      return MiniStatusline.combine_groups({
        -- 左侧：显示窗口编号，用来替代原先的 Mode 位置
        { hl = 'MiniStatuslineInactive', strings = { string.format('󰕰 %d', winnr) } },
        -- 右侧：显示文件路径
        { hl = 'MiniStatuslineInactive', strings = { filename } },
      })
    end,
  },
})

-- =============================================================================
-- mini.surround
-- =============================================================================
require('mini.surround').setup({
  mappings = {
    add = 'ma',
    delete = 'me',
    find = '',
    find_left = '',
    highlight = '',
    replace = 'mc',
    suffix_last = '',
    suffix_next = '',
  },
})

-- =============================================================================
-- mini.tabline
-- =============================================================================
require('mini.tabline').setup({})

-- =============================================================================
-- mini.trailspace
-- =============================================================================
require('mini.trailspace').setup({})

-- =============================================================================
-- mini.visits
-- =============================================================================
require('mini.visits').setup({})
