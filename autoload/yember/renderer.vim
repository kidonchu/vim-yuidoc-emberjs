function! yember#renderer#RenderSnip(template, data)

	" Get docblock from template with handlebar tags resolved
	let l:docblock = vmustache#RenderFile(a:template, a:data) . "\n"
	let l:snippet = join(s:ApplyIndent(l:docblock, a:data["indent"]), "\n")

	" trick to correctly insert doc block above the current line
	let l:lineNum = line(".")
	call append(l:lineNum - 1, [""])
	call cursor(l:lineNum, 0)

	call UltiSnips#Anon(l:snippet)

endfunction

function! s:ApplyIndent(text, indent)
	let l:lines = split(a:text, "\n")
	return map(l:lines, '"' . a:indent . '" . v:val')
endfunction
