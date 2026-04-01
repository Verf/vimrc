-- [[ Leader 键设置 ]]
vim.g.mapleader = ' ' -- 全局 Leader 键
vim.g.maplocalleader = ',' -- 将局部 Leader 键（通常用于特定文件类型插件）

-- [[ GUI 配置]]
vim.opt.guifont = 'Maple Mono NF CN:h13' -- GUI字体

-- neovide
if vim.g.neovide then
    vim.g.neovide_refresh_rate = 60 -- 屏幕刷新率
    vim.g.neovide_no_idle = true -- 减少空闲时卡顿
    vim.g.neovide_cursor_trail_size = 0 -- 关闭光标拖尾
    vim.g.neovide_scroll_animation_length = 0 -- 关闭平滑滚动
    vim.g.neovide_cursor_animation_length = 0 -- 关闭光标动画
    vim.g.neovide_cursor_vfx_mode = '' -- 关闭光标特效
    vim.g.neovide_opacity = 1 -- 关闭背景透明

    vim.g.neovide_floating_shadow = true -- 浮动窗口阴影特效
    vim.g.neovide_floating_z_height = 4 -- 阴影Z轴偏移
    vim.g.neovide_floating_corner_radius = 0.0 -- 浮动窗口圆角

    vim.g.neovide_hide_mouse_when_typing = true -- 打字时隐藏鼠标
    vim.g.neovide_remember_window_size = true -- 记住窗口大小
end

-- [[ 核心配置 ]]
vim.opt.confirm = true -- 在执行需要确认的操作时（如退出未保存的文件），弹出对话框进行确认
vim.opt.autowrite = true -- 自动保存。在执行某些命令（如 :make）或切换缓冲区时自动写入文件
vim.opt.cindent = true -- 开启 C/C++ 风格的自动缩进
vim.opt.cursorline = true -- 高亮显示光标所在的行
vim.opt.ignorecase = true -- 搜索时忽略大小写
vim.opt.infercase = true -- 自动补充时忽略大小写
vim.opt.smartcase = true -- 智能大小写搜索。当搜索词全为小写时忽略大小写，当包含大写字母时则进行大小写敏感搜索

vim.opt.wrap = false -- 禁用自动换行，保持长行在同一行显示

vim.opt.ruler = true -- 在状态栏右下角显示光标的行号和列号
vim.opt.number = true -- 显示行号
vim.opt.relativenumber = true -- 显示相对行号，当前行为绝对行号，其他行为距离当前行的行数
vim.opt.showmatch = true -- 高亮显示匹配的括号，比如 ()、[]、{}
vim.opt.showmode = false -- 不显示当前模式（如 -- INSERT --）
vim.opt.showcmd = false -- 不在右下角显示未完成的命令
vim.opt.hlsearch = false -- 禁用搜索结果高亮，避免视觉干扰

vim.opt.showtabline = 2 -- 总是显示标签页栏

vim.opt.mouse = 'a' -- 在所有模式下（普通、可视、插入等）启用鼠标支持
vim.opt.splitkeep = 'screen' -- 分屏时保持相对位置更稳定
vim.opt.splitright = true -- 竖向分屏时将新窗口放在右边
vim.opt.switchbuf = 'usetab' -- 执行特定跳转时优先复用已有标签页，若没有则新建标签页打开
vim.opt.virtualedit = 'block' -- 启用虚拟编辑，允许光标在块选择模式下移动到没有实际字符的列

vim.opt.expandtab = true -- 将输入的 Tab 自动转换为空格
vim.opt.tabstop = 4 -- 设置文件中一个 Tab 字符代表的空格数
vim.opt.shiftwidth = 4 -- 设置自动缩进和手动缩进（如使用 >>）的空格数为 4
vim.opt.softtabstop = 4 -- 设置在编辑模式下，按 Tab 键插入的空格数

vim.opt.scrolloff = 999 -- 设置光标距离窗口顶部和底部的最小行数，999可以使光标始终保持在屏幕中央
vim.opt.updatetime = 750 -- 设置更新交换文件和触发 CursorHold 事件的延迟时间（毫秒）

vim.opt.foldenable = true -- 开启折叠
vim.opt.foldcolumn = '1' -- 显示折叠列
vim.opt.foldlevel = 99 -- 默认折叠级别
vim.opt.foldlevelstart = 99 -- 打开buffer时的默认折叠级别

vim.opt.complete = '.,w,b,kspell' -- 内置自动补全数据源
vim.opt.completeopt = 'menuone,noselect,fuzzy,nosort' -- 内置自动补全菜单配置

vim.opt.fileformats = 'unix,dos' -- 设置识别的文件格式，优先使用 unix 换行符 (\n)
vim.opt.iskeyword = '@,48-57,_,192-255,-' -- 将-也视为word一部分

vim.opt.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]] -- 识别数字开头列表，对应'formatoptions'的n
vim.opt.formatoptions = 'rqnl1j' -- 增强自动注释的体验

vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize' -- 设置 :mksession 命令保存的会话内容

vim.opt.fillchars = {
    eob = ' ', -- 隐藏缓冲区末尾的 `~`

    vert = '│', -- 垂直分割线
    horiz = '─', -- 水平分割线
    vertleft = '┤', -- 垂直线接左水平线
    vertright = '├', -- 垂直线接右水平线
    verthoriz = '┼', -- 十字交叉点
    horizup = '┴', -- 水平线接上垂直线
    horizdown = '┬', -- 水平线接下垂直线

    fold = ' ', -- 隐藏折叠行的默认填充点，保持干净
    foldopen = '', -- 折叠打开时的图标 (Nerd Font: chevron-down)
    foldclose = '', -- 折叠关闭时的图标 (Nerd Font: chevron-right)
    foldsep = '│', -- 折叠边距的垂直引导线，展示作用域层级

    diff = '╱', -- 使用斜纹填充被删除/空白的区域，比破折号 `-` 更有高级感

    msgsep = '‾', -- 命令行与编辑区之间的分隔符
}

-- 全局函数用于精准计算每一行应该显示的折叠图标
_G.custom_fold_icon = function()
    local lnum = vim.v.lnum
    local fold_closed = vim.fn.foldclosed(lnum)
    local fcs = vim.opt.fillchars:get()

    -- 1. 已闭合的折叠：永远显示合上的图标
    if fold_closed == lnum then return (fcs.foldclose or '') .. ' ' end

    -- 2. 若光标所在行是折叠起点时，显示展开的图标
    if lnum == vim.fn.line '.' then
        local fold_level = vim.fn.foldlevel(lnum)
        local fold_level_before = lnum == 1 and 0 or vim.fn.foldlevel(lnum - 1)

        -- 如果当前行的折叠层级大于上一行，说明这里是代码块/函数的起点
        if fold_level > fold_level_before then return (fcs.foldopen or '') .. ' ' end
    end

    -- 3. 其他所有行留白
    return '  '
end

-- statuscolumn：
--   %s           : 诊断错误(LSP)/Git状态等符号列
--   %=           : 将后面的内容向右对齐
--   %l           : 智能行号
--   %#FoldColumn#: 切换到 FoldColumn 高亮组
--   %{...}       : 执行 Lua 逻辑，只渲染图标，避免折叠数字
--   %*           : 恢复默认高亮
vim.opt.statuscolumn = '%s%=%l %#FoldColumn#%{v:lua.custom_fold_icon()}%*'

-- [[ diagnostic ]]
vim.diagnostic.config {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
        },
    },
    virtual_text = {
        source = 'always',
    },
    float = {
        source = 'always',
    },
    severity_sort = true,
}

-- [[ shell ]]
if vim.fn.executable 'nu' == 1 then
    vim.opt.shell = 'nu'
    vim.opt.shellcmdflag = '--login --stdin --no-newline -c'
    vim.opt.shellredir = 'out+err> %s'
    vim.opt.shellpipe = '| save --force %s'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = ''
    vim.opt.shellxescape = ''
    vim.opt.shelltemp = false
end

-- [[ grep ]]
if vim.fn.executable 'rg' == 1 then
    vim.opt.grepprg = 'rg --vimgrep --smart-case --no-heading'
    vim.opt.grepformat = '%f:%l:%c:%m'
end

-- 创建一个自定义命令 :Grep 来替代原生的 :grep 以静默输出
vim.api.nvim_create_user_command('Grep', function(opts) vim.cmd('silent grep! ' .. opts.args) end, { nargs = '+', complete = 'file' })

-- [[ quickfix ]]
-- grep或make后自动打开quickfix
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
    pattern = '[^l]*', -- 匹配 grep, make 等（排除 lgrep 等局部列表命令）
    callback = function()
        vim.cmd 'cwindow' -- 有结果才打开，没结果不打开
    end,
})

-- [[ autocmd ]]
-- 在当前注释中按o插入新行后不自动添加注释符，在 FileType 时调用以自动覆盖文件类似特定的配置
vim.api.nvim_create_autocmd('FileType', {
    callback = function() vim.cmd 'setlocal formatoptions-=c formatoptions-=o' end,
    desc = "Proper 'formatoptions'",
})

-- 失去焦点时自动保存
vim.api.nvim_create_autocmd({ 'FocusLost', 'BufLeave' }, {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- 1. 检查 Buffer 是否被修改过 (modified)
        if not vim.api.nvim_buf_get_option(bufnr, 'modified') then return end

        -- 2. 检查文件名是否为空 (排除未命名的新文件)
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname == '' then return end

        -- 3. 排除特定的 buftype (只保存普通文件)
        -- 排除：terminal, prompt, quickfix, nofile (如 NvimTree, Telescope 等)
        local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
        if buftype ~= '' then return end

        -- 4. 排除只读文件
        if vim.api.nvim_buf_get_option(bufnr, 'readonly') then return end

        -- 5. 排除特定的 filetype
        local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
        local exclude_ft = { 'gitcommit', 'gitrebase' }
        if vim.tbl_contains(exclude_ft, filetype) then return end

        -- 执行保存：silent! 忽略可能产生的错误（如权限不足），update 仅在有改动时写入
        vim.cmd 'silent! update'
    end,
    desc = 'Auto save when focus lost',
})
