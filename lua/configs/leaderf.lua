local g = vim.g
local map = require('utils').map

g.Lf_ShortcutF = '<leader>ff'
g.Lf_ShortcutB = '<leader>bb'
g.Lf_WindowHeight = 0.30
g.Lf_StlColorscheme = 'one'
g.Lf_PopupColorscheme = 'one'
g.Lf_WindowPosition = 'popup'
g.Lf_DefaultExternalTool = 'rg'
g.Lf_IgnoreCurrentBufferName = 1
g.Lf_RootMarkers = {'.git', '.gitignore', '.project', 'pom.xml', 'setup.py'}
g.Lf_StlSeparator = { left= '', right = '', font = '更纱黑体 Mono SC Nerd' }
g.Lf_WildIgnore = {
    dir = {'.git', '.vscode', '.cache', '.vim'},
    file = {'*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]'}
}
g.Lf_CommandMap = {
    ['<C-j>'] = {'<C-n>'},
    ['<C-k>'] = {'<C-i>'},
    ['<C-]>'] = {'<C-->'},
    ['<C-x>'] = {'<C-|>'},
}

map('n', '<leader>fa', ':LeaderfFile $HOME<CR>')
map('n', '<leader>ft', ':LeaderfBufTag<CR>')
map('n', '<leader>fh', ':Leaderf mru<CR>')
map('n', '<leader>fp', ':<C-R>=printf(\'Leaderf rg -e %s \', expand(\'<cword>\'))<CR><CR>')
map('n', '<leader>fw', ':<C-R>=printf(\'Leaderf rg -e \')<CR>')