" default to plugin directory's templates
if !exists('g:yember_template_path')
	let s:yember_plugin_path = escape(expand('<sfile>:p:h:h'), '\')
	let g:yember_template_path = s:yember_plugin_path . '/templates/'
endif

" order matters
let s:types = [
	\ yember#class#Init(),
	\ yember#event#Init(),
	\ yember#function#Init(),
	\ yember#attribute#Init(),
	\ yember#computedp#Init(),
	\ yember#property#Init(),
	\ yember#default#Init()
\ ]

function! yember#GenerateYuiDocBlock()

	let l:text = getline(".")

	let l:data = {}
	let l:template = ''
	for l:type in s:types
		if l:type['is_match'](l:text)
			let l:data = l:type['parse_data'](l:text)
			let l:template = g:yember_template_path . l:type['template']
			break
		endif
	endfor

	call yember#renderer#RenderSnip(l:template, l:data)

endfunction
