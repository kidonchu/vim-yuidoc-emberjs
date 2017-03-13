" default to plugin directory's templates
if !exists('g:yember_template_path')
	let s:yember_plugin_path = escape(expand('<sfile>:p:h:h'), '\')
	let g:yember_template_path = s:yember_plugin_path . '/templates/'
endif

function! yember#GetTemplatePath()
	return g:yember_template_path
endfunction
