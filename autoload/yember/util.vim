" Tries to guess the type of given value
"
" @param string value
" @return string value's type
function! yember#util#GuessType(value)
	if a:value =~ '\v^['
		return "Array"
	endif
	if a:value =~ '\v^[0-9.]+'
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
