let s:regex = '\v^(\s*)?export default .{-}(Route|Controller|Model|Service|Mixin|Component)\.extend\((.{-})?\{'

function! yember#class#Init()
	return {
		\ 'is_match': function('yember#class#IsMatch'),
		\ 'parse_data': function('yember#class#ParseData'),
		\ 'template': 'class.tpl'
	\ }
endfunction

function! yember#class#IsMatch(text)
	return (match(a:text, s:regex) > -1)
endfunction

function! yember#class#ParseData(text)

	let l:matches = matchlist(a:text, s:regex)

	let l:data = {}
	let l:data["indent"] = l:matches[1]
	let l:data["namespace"] = l:matches[2]
	if l:matches[3] != ''
		let l:data["uses"] = l:matches[3]
	endif

	let l:data["class"] = s:GetClass()

	return l:data

endfunction

" Returns class name from current file's name
function! s:GetClass()

	let l:filename = expand('%:t:r')
	let l:parts = split(l:filename, '-')

	let l:ret = []
	for l:part in l:parts
		let l:upperCased = substitute(l:part, '\v(\k)(\k*)', '\u\1\2', '')
		call add(l:ret, l:upperCased)
	endfor

	return join(l:ret, '')

endfunction
