-- 创建一个自定义命令 :Grep 来替代原生的 :grep 以静默输出
vim.api.nvim_create_user_command(
    'Grep',
    function(opts) vim.cmd('silent grep! ' .. opts.args) end,
    { nargs = '+', complete = 'file' }
)
