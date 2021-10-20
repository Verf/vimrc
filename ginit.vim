let s:fontname = "Sarasa Mono SC Nerd"
let s:fontsize = 13
let s:curfontsize = 13

function! SetDefaultFont()
  :execute "GuiFont! " . s:fontname . ":h" . s:fontsize
endfunction

function! AdjustFontSize(amount)
  let s:curfontsize = s:curfontsize + a:amount
  :execute "GuiFont! " . s:fontname. ":h" . s:curfontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

if exists(':GuiTabline')
    GuiTabline 0
endif

if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

call SetDefaultFont()
call GuiWindowMaximized(1)
