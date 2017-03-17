" Tries to guess the type of given value
"
" @param string value
" @return string value's type
function! yember#util#GuessType(value)
	if a:value =~ '\v^['
		return "Array"
	endif
	if a:value =~ '\v^[-0-9\.]+'
		return "Number"
	endif
	if a:value =~ '\v[''"].*[''"]'
		return "String"
	endif
	if a:value =~ '\v(true|false)'
		return "Boolean"
	endif
	return ""
endfunction

function! yember#util#TrimList(parts)
	let l:trimmed_parts = []
	for l:part in a:parts
		let l:trimmed = substitute(l:part, '\v^\s*(.{-})\s*$', '\1', 'e')
		call add(l:trimmed_parts, l:trimmed)
	endfor
	return l:trimmed_parts
endfunction
