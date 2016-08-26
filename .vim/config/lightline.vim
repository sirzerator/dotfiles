" Lightline
if exists("g:plugs['lightline.vim']")
	set laststatus=2

	let g:lightline = {
	\ 'colorscheme': 'jellybeans',
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' },
	\ 'active': {
	\   'left': [ [ 'fugitive' ], [ 'readonly', 'filename', 'modified' ], [ 'ctrlpmark' ] ],
	\   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'inactive': {
	\   'left': [ [ 'readonly', 'filename', 'modified' ] ],
	\   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'component_visible_condition': {
	\   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
	\ },
	\ 'component': {
	\   'fugitive': '%{(exists("*fugitive#head") && ""!=fugitive#head())?"\ue0a0 ".fugitive#head():""}'
	\ },
	\ 'component_function': {
	\   'modified': 'LightLineModified',
	\   'filename': 'LightLineFilename',
	\   'fileformat': 'LightLineFileformat',
	\   'filetype': 'LightLineFiletype',
	\   'fileencoding': 'LightLineFileencoding',
	\   'readonly': 'LightLineReadonly',
	\   'ctrlpmark': 'CtrlPMark'
	\ },
	\ }

	function! LightLineModified()
		return &ft =~ 'help\|qf\|netrw\|fugitiveblame' ? '' : &modified ? '+' : &modifiable ? '' : '-'
	endfunction

	function! LightLineReadonly()
		return &ft !~? 'help\|qf\|netrw\|fugitiveblame' && &readonly ? "\ue0a2" : ''
	endfunction

	function! LightLineFilename()
		let fname = expand('%f')
		return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
			\ &ft !~? 'qf\|fugitiveblame' ? ('' != fname ? fname : '[No Name]') : ''
	endfunction

	function! LightLineFileformat()
		return winwidth(0) > 70 ? &fileformat : ''
	endfunction

	function! LightLineFiletype()
		return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
	endfunction

	function! LightLineFileencoding()
		return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
	endfunction

	function! CtrlPMark()
		if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
			call lightline#link('iR'[g:lightline.ctrlp_regex])
			return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item, g:lightline.ctrlp_next], 0)
		else
			return ''
		endif
	endfunction

	let g:ctrlp_status_func = {
	  \ 'main': 'CtrlPStatusFunc_1',
	  \ 'prog': 'CtrlPStatusFunc_2',
	  \ }

	function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
		let g:lightline.ctrlp_regex = a:regex
		let g:lightline.ctrlp_prev = a:prev
		let g:lightline.ctrlp_item = a:item
		let g:lightline.ctrlp_next = a:next
		return lightline#statusline(0)
	endfunction

	function! CtrlPStatusFunc_2(str)
		  return lightline#statusline(0)
	endfunction
endif
