-- [[ Markdown 文件类型优化 ]]

-- 缩进：2 空格
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- 软换行：视觉换行，不插入硬换行符
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.bo.textwidth = 0

-- 拼写检查
vim.wo.spell = true

-- 修正 formatoptions（覆盖 30_autocmds.lua 的全局 'c' 'o' 移除）
-- t: 按 textwidth 自动换行 / c: 自动续行列表 / q: 允许 gq 格式化
-- l: 插入模式下不断行长行 / n: 识别编号列表 / j: 合并时移除注释前缀
vim.bo.formatoptions = 'tcqlnj'

-- 不显示 colorcolumn，避免干扰阅读
vim.wo.colorcolumn = ''
