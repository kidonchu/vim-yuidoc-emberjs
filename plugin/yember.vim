" yember.vim - Yember
" Author: Kidon Chu <https://github.com/kidonchu>
" Version: 0.1.0

" The usual guard that prevents the plugin from being loaded multiple times
if exists("g:loaded_yember") || &cp || v:version < 700
  finish
endif
let g:loaded_yember = 1

nnoremap <silent> <Plug>GenerateYuiDocBlock :<C-U>call yember#GenerateYuiDocBlock()<CR>

if !exists("g:yember_no_mappings") || ! g:yember_no_mappings

  nmap <F2> <Plug>GenerateYuiDocBlock

end
