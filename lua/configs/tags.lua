local g = vim.g

g['gutentags_project_root '] = {'.git', '.project'}
g['gutentags_cache_dir'] = vim.fn.stdpath("data") .. '/ctags'
g['gutentags_generate_on_write'] = 1
