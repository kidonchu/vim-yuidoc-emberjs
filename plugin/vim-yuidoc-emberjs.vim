" vim-yuidoc-emberjs.vim
" Author: Kidon Chu <https://github.com/kidonchu>
" Version: 0.1.0

" The usual guard that prevents the plugin from being loaded multiple times
if exists("g:loaded_vim_yuidoc_emberjs") || &cp || v:version < 700
  finish
endif
let g:loaded_vim_yuidoc_emberjs = 1

function! s:dofunction()
  " use :messages to see if this works
  echom "test"
endfunction

nnoremap <silent> <Plug>DocumentYUIDocEmberjs :<C-U>call <SID>dofunction()<CR>

if !exists("g:vim_yuidoc_emberjs_no_mappings") || ! g:vim_yuidoc_emberjs_no_mappings

  nmap <F2> <Plug>DocumentYUIDocEmberjs

end
