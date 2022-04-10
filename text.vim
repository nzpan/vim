scriptencoding utf-8

let b:FcitxState = 2

syn sync fromstart
set foldmethod=expr
syn match End display "  $"
hi def link End Conceal
nmap <C-H> zc

set fillchars=

function! FoldExpr_(lnum) 
  let level = len(matchstr(getline(a:lnum  ),'^#\+ '))-1 
  let nextlevel = len(matchstr(getline(a:lnum+1),'^#\+ '))-1 
  if level > 0 && level == nextlevel
    return level-1
  endif
  return level > 0 && level < nextlevel ? level : nextlevel > 0 ? '<'.nextlevel : (level == -1 ? '=' : level)
endfunction

function! FoldText_()

  return getline(v:foldstart)
endfunction
setlocal foldenable foldmethod=expr foldexpr=FoldExpr_(v:lnum) foldtext=FoldText_()

syn match Headline	"^#.*"
hi def link Headline	String

map <buffer> [[ ?^# <CR>:nohlsearch<CR>
map <buffer> ]] /^# <CR>:nohlsearch<CR>
map <buffer> [2 ?^##<CR>:nohlsearch<CR>
map <buffer> ]2 /^##<CR>:nohlsearch<CR>
map <buffer> 2[ ?^##<CR>:nohlsearch<CR>
map <buffer> 2] /^##<CR>:nohlsearch<CR>
