let s:regex = '\v^(\s*)?export default .{-}(Route|Controller|Model|Service|Mixin|Component)\.(extend|create)\((.{-})?\{'

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
	if l:matches[4] != ''
		let l:data["uses"] = l:matches[4]
	endif

	let l:className = s:GetClassFromFilename()

	" if class name is one of generic name, use directory's name for class
	if index(['Component', 'Route', 'Controller'], l:className) != -1
		let l:className = s:GetClassFromDirname()
	endif

	let l:data['class'] = l:className

	return l:data

endfunction

" Returns class name from current file's name
function! s:GetClassFromFilename()

	let l:filename = expand('%:t:r')
	let l:parts = split(l:filename, '-')

	return s:ConvertDashedName(l:parts)

endfunction

" Returns class name from current file's directory's name
function! s:GetClassFromDirname()

	let l:dirname = expand('%:h:t')
	let l:parts = split(l:dirname, '-')

	return s:ConvertDashedName(l:parts)

endfunction

" Converts dashed-name into DashedName in upper camel cases
function! s:ConvertDashedName(parts)
	
	let l:ret = []
	for l:part in a:parts
		let l:upperCased = substitute(l:part, '\v(\k)(\k*)', '\u\1\2', '')
		call add(l:ret, l:upperCased)
	endfor

	return join(l:ret, '')

endfunction
