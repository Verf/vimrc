local map = require('utils').map

map('', '<F2>', ':Fern . -drawer -toggle<CR>')
-- vim.g['fern#disable_default_mappings'] = 1
-- vim.api.nvim_exec(
-- [[
-- function! s:init_fern() abort
-- nmap <buffer> <CR> <Plug>(fern-action-open:edit)
-- nmap <buffer> t <Plug>(fern-action-open:tabedit)
-- nmap <buffer> - <Plug>(fern-action-open:split)
-- nmap <buffer> | <Plug>(fern-action-open:vsplit)
-- nmap <buffer> <C-Enter> <Plug>(fern-action-enter)
-- nmap <buffer> <BS> <Plug>(fern-action-leave)
-- nmap <buffer> r <Plug>(fern-action-reload)
-- nmap <buffer> j <Plug>(fern-action-cd)
-- nmap <buffer> . <Plug>(fern-action-hide-toggle)
-- nmap <buffer> q :<C-u>quit<CR>
-- nmap <buffer> c <Plug>(fern-action-clipboard-copy)
-- nmap <buffer> v <Plug>(fern-action-clipboard-paste)
-- nmap <buffer> m <Plug>(fern-action-move)
-- nmap <buffer> C <Plug>(fern-action-copy)
-- nmap <buffer> X <Plug>(fern-action-remove)
-- endfunction
-- ]], false
-- )
