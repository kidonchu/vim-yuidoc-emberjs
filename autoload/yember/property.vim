" In order to add a doc block type to yember, following set of functions MUST be
" implemented.
" Init() - MUST return dictionary of followings:
"   * is_match(string): boolean
"     Returns whether given string is a match for current type
"   * parse_data(string): dictionary
"     Returns extracted data from given string
"   * template
"     Name of the template to be used to render doc block

let s:regex = '\v^(\s*)(\S+):\s+(.{-}),?$'

function! yember#property#Init()
	return {
		\ 'is_match': function('yember#property#IsMatch'),
		\ 'parse_data': function('yember#property#ParseData'),
		\ 'template': 'property.tpl'
	\ }
endfunction

function! yember#property#IsMatch(text)
	return (match(a:text, s:regex) > -1)
endfunction

function! yember#property#ParseData(text)

	let l:matches = matchlist(a:text, s:regex)

	let l:data = {}
	let l:data["indent"] = l:matches[1]
	let l:data["name"] = l:matches[2]
	let l:data["default"] = l:matches[3]
	let l:data["type"] = yember#util#GuessType(l:matches[3])

	return l:data
endfunction
