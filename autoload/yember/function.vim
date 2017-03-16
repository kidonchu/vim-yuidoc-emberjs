let s:fnRegex = '\v^(\s*)(\S+)+:\s?function\('
let s:altFnRegex = '\v^(\s*)(\S+)\s?\('
let s:paramRegex = '\v\s*\S+:\s?function\(([^\)]{-})\)\s?\{'
let s:altParamRegex = '\v\s*\S+\s?\(([^\)]{-})\)\s?\{'

function! yember#function#Init()
	return {
		\ 'is_match': function('yember#function#IsMatch'),
		\ 'parse_data': function('yember#function#ParseData'),
		\ 'template': 'function.tpl'
	\ }
endfunction

function! yember#function#IsMatch(text)
	return (match(a:text, s:fnRegex) > -1) || (match(a:text, s:altFnRegex) > -1)
endfunction

function! yember#function#ParseData(text)

	let l:data = s:ParseBasicData(a:text)
	let l:data['parameters'] = s:ParseParameterData(a:text)

	return l:data

endfunction

function! s:ParseBasicData(text)

	let l:matches = matchlist(a:text, s:fnRegex)
	if len(l:matches) == 0
		let l:matches = matchlist(a:text, s:altFnRegex)
	endif

	let l:data = {}
	let l:data["indent"] = l:matches[1]
	let l:data["name"] = l:matches[2]

	return l:data

endfunction

function! s:ParseParameterData(text)

	let l:matches = matchlist(a:text, s:paramRegex)
	if len(l:matches) == 0
		let l:matches = matchlist(a:text, s:altParamRegex)
	endif

	" extract a list of params
	let l:params = split(l:matches[1], ',')
	let l:params = map(l:params, substitute('v:val', '\v^\s*(\S*)\s*$', '\1', 'e'))

	let l:parameters = []
	for l:param in l:params
		let l:data = {}
		let l:data['name'] = l:param
		let l:data['type'] = 'Mixed'
		call add(l:parameters, l:data)
	endfor

	return l:parameters

endfunction
