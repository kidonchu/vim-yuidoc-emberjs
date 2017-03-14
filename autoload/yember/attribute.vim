let s:regex = '\v^(\s*)(\S+):\s+DS\.attr\([''"]?(.{-})[''"]?\),?$'

function! yember#attribute#Init()
	return {
		\ 'is_match': function('yember#attribute#IsMatch'),
		\ 'parse_data': function('yember#attribute#ParseData'),
		\ 'template': 'attribute.tpl'
	\ }
endfunction

function! yember#attribute#IsMatch(text)
	return (match(a:text, s:regex) > -1)
endfunction

function! yember#attribute#ParseData(text)

	let l:matches = matchlist(a:text, s:regex)

	let l:data = {}
	let l:data["indent"] = l:matches[1]
	let l:data["name"] = l:matches[2]
	let l:data["type"] = s:GetAttrType(l:matches[3])

	return l:data

endfunction

function! s:GetAttrType(typeString)
	echom "s:typeString: " . a:typeString
	if a:typeString == 'string'
		return 'String'
	elseif a:typeString == 'date'
		return 'Date'
	elseif a:typeString == 'boolean'
		return 'Boolean'
	elseif a:typeString == 'number'
		return 'Number'
	else
		return ''
	endif
endfunction
