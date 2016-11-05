" CtrlP
if exists("g:plugs['ctrlp.vim']")
	let g:ctrlp_clear_cache_on_exit = 0
	let g:ctrlp_custom_ignore = {
	  \ 'dir':  '\.git$\|vendor$\|public$\|node_modules\|log\|tmp$',
	  \ 'file': '\.so$\|\.dat$|\.DS_Store|\.pyc$$'
	  \ }
	let g:ctrlp_switch_buffer = 0
endif
