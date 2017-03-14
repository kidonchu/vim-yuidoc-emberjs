" In order to add a doc block type to yember, following set of functions MUST be
" implemented.
" Init() - MUST return dictionary of followings:
"   * is_match(string): boolean
"     Returns whether given string is a match for current type
"   * parse_data(string): dictionary
"     Returns extracted data from given string
"   * template
"     Name of the template to be used to render doc block
let s:regex = '\v^(\s*).*$'

function! yember#default#Init()
	return {
		\ 'is_match': function('yember#default#IsMatch'),
		\ 'parse_data': function('yember#default#ParseData'),
		\ 'template': 'default.tpl'
	\ }
endfunction

function! yember#default#IsMatch(text)
	return (match(a:text, s:regex) > -1)
endfunction

function! yember#default#ParseData(text)

	let l:matches = matchlist(a:text, s:regex)

	let l:data = {}
	let l:data["indent"] = l:matches[1]

	return l:data

endfunction
