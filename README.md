# vim-yuidoc-emberjs
Ember-specific YUIDoc doc block generator

## Installation
In your .vimrc,
```
Plug 'kidonchu/yember'
```

## How to use
By default, the key mapping to generate the doc block is
```
nmap <F2> <Plug>GenerateYuiDocBlock
```
In order to use custom key mapping, replace `<F2>` with any key you want and add the following to your .vimrc.
```
let g:yember_no_mappings = 0
```
In order to generate a doc block, the cursor should be on the line with the code you want to generate the doc block with.
