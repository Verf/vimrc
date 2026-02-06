-- 创建局部变量别名，方便后续调用
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

-- [[ Leader 键设置 ]]
g.mapleader = ' ' -- 全局 Leader 键
g.maplocalleader = ',' -- 将局部 Leader 键（通常用于特定文件类型插件）

-- [[ 核心配置 ]]
opt.autowrite = true -- 自动保存。在执行某些命令（如 :make）或切换缓冲区时自动写入文件
opt.cindent = true -- 开启 C/C++ 风格的自动缩进
opt.confirm = true -- 在执行需要确认的操作时（如退出未保存的文件），弹出对话框进行确认
opt.cursorline = true -- 高亮显示光标所在的行
opt.expandtab = true -- 将输入的 Tab 自动转换为空格
opt.hlsearch = false -- 禁用搜索结果高亮，避免视觉干扰
opt.ignorecase = true -- 搜索时忽略大小写
opt.infercase = true -- 自动补充时忽略大小写
opt.number = true -- 显示行号
opt.relativenumber = true -- 显示相对行号，当前行为绝对行号，其他行为距离当前行的行数
opt.ruler = true -- 在状态栏右下角显示光标的行号和列号
opt.showcmd = false -- 不在右下角显示未完成的命令
opt.showmatch = true -- 高亮显示匹配的括号，比如 ()、[]、{}
opt.showmode = false -- 不显示当前模式（如 -- INSERT --）
opt.smartcase = true -- 智能大小写搜索。当搜索词全为小写时忽略大小写，当包含大写字母时则进行大小写敏感搜索
opt.wrap = false -- 禁用自动换行，保持长行在同一行显示

opt.scrolloff = 999 -- 设置光标距离窗口顶部和底部的最小行数，999可以使光标始终保持在屏幕中央
opt.shiftwidth = 4 -- 设置自动缩进和手动缩进（如使用 >>）的空格数为 4
opt.showtabline = 2 -- 总是显示标签页栏 (tabline)
opt.softtabstop = 4 -- 设置在编辑模式下，按 Tab 键插入的空格数
opt.tabstop = 4 -- 设置文件中一个 Tab 字符代表的空格数
opt.updatetime = 750 -- 设置更新交换文件和触发 CursorHold 事件的延迟时间（毫秒）

opt.complete = '.,w,b,kspell' -- 内置自动补全数据源
opt.completeopt = 'menuone,noselect,fuzzy,nosort' -- 内置自动补全菜单配置
opt.fileformats = 'unix,dos' -- 设置识别的文件格式，优先使用 unix 换行符 (\n)
opt.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]
opt.formatoptions = 'rqnl1j' -- 增强自动注释的体验
opt.iskeyword = '@,48-57,_,192-255,-' -- -也作为word一部分
opt.mouse = 'a' -- 在所有模式下（普通、可视、插入等）启用鼠标支持
opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize' -- 设置 :mksession 命令保存的会话内容
opt.shell = 'nu' -- 设置用于执行外部命令的 shell 程序为 nu (nushell)
opt.shellcmdflag = '-c' -- 设置传递给 shell 的标志，以执行命令
opt.shellquote = '' -- 设置引用传递给 shell 的命令的方式
opt.shellxquote = '' -- 类似于 shellquote，但用于重定向
opt.spelloptions = 'camel' -- 将CamelCase单词视为多个单词
opt.splitkeep = 'screen' -- 分屏时保持相对位置更稳定
opt.switchbuf = 'usetab' -- 执行特定跳转时优先复用已有标签页，若没有则新建标签页打开
opt.virtualedit = 'block' -- 启用虚拟编辑，允许光标在块选择模式下移动到没有实际字符的列
-- autocmd
-- 在当前注释中按o插入新行后不自动添加注释符，在 FileType 时调用以自动覆盖文件类似特定的配置
local f = function() vim.cmd 'setlocal formatoptions-=c formatoptions-=o' end
_G.Config.new_autocmd('FileType', nil, f, "Proper 'formatoptions'")
