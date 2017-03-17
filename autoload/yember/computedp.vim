let s:methods = [
	\ 'alias', 'and', 'bool', 'collect', 'deprecatingAlias', 'empty',
	\ 'equal', 'filter', 'filterBy', 'gt', 'gte', 'intersect', 'lt',
	\ 'lte', 'map', 'mapBy', 'match', 'max', 'min', 'none', 'not',
	\ 'notEmpty', 'oneWay', 'or', 'readOnly', 'reads', 'setDiff',
	\ 'sort', 'sum', 'union', 'uniq', 'uniqBy', 'computed'
\ ]

" propertyName: Ember.computed('p1', 'p2', function(){})
let s:regex = '\v^(\s*)(\S+):\s+(Ember\.)?('.join(s:methods, '|').')\('

function! yember#computedp#Init()
	return {
		\ 'is_match': function('yember#computedp#IsMatch'),
		\ 'parse_data': function('yember#computedp#ParseData'),
		\ 'template': 'computedp.tpl'
	\ }
endfunction

function! yember#computedp#IsMatch(text)
	return (match(a:text, s:regex) > -1)
endfunction

function! yember#computedp#ParseData(text)

	let l:matches = matchlist(a:text, s:regex)

	let l:data = {}
	let l:data["indent"] = l:matches[1]
	let l:data["name"] = l:matches[2]

	return l:data
endfunction
