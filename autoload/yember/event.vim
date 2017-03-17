let s:hooks = [
	\ 'init', 'didReceiveAttrs', 'willRender', 'didInsertElement', 'didRender',
	\ 'didUpdateAttrs', 'didReceiveAttrs', 'willUpdate', 'willRender', 'didUpdate',
	\ 'didRender', 'willDestroyElement', 'willClearRender', 'didDestroyElement',
	\ 'activate', 'beforeModel', 'model', 'afterModel', 'serialize', 'setupController',
	\ 'renderTemplate', 'deactivate', 'willTransition', 'didTransition'
\ ]

let s:fnRegex = '\v^(\s*)('.join(s:hooks, '|').')'
let s:paramRegex = '\v\s*\S+:\s?function\(([^\)]{-})\)\s?\{'
let s:altParamRegex = '\v\s*\S+\s?\(([^\)]{-})\)\s?\{'

function! yember#event#Init()
	return {
		\ 'is_match': function('yember#event#IsMatch'),
		\ 'parse_data': function('yember#event#ParseData'),
		\ 'template': 'event.tpl'
	\ }
endfunction

function! yember#event#IsMatch(text)
	return (match(a:text, s:fnRegex) > -1)
endfunction

function! yember#event#ParseData(text)

	let l:data = s:ParseBasicData(a:text)
	let l:data['parameters'] = s:ParseParameterData(a:text)

	return l:data

endfunction

function! s:ParseBasicData(text)

	let l:matches = matchlist(a:text, s:fnRegex)

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
	let l:params =  yember#util#TrimList(l:params)

	let l:parameters = []
	for l:param in l:params
		let l:data = {}
		let l:data['name'] = l:param
		let l:data['type'] = 'Mixed'
		call add(l:parameters, l:data)
	endfor

	return l:parameters

endfunction
