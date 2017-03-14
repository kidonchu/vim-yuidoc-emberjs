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
	let l:data["uses"] = l:matches[3]

	let l:filename = expand('%:r')
	let l:parts = split(l:filename, '-')
	let l:index = 0
	let l:transformed = []
	for l:part in l:parts
		let l:tmp = substitute(l:part, '\v(\k)(\k*)', '\u\1\2', '')
		let l:transformed = l:transformed + [l:tmp]
		let l:index += 1
	endfor

	let l:data["class"] = join(l:transformed, '')

	return l:data

endfunction
