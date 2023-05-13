if exists("g:plugs['lightline.vim']")
	set laststatus=2

	let g:lightline = {
	\ 'colorscheme': 'jellybeans',
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' },
	\ 'active': {
	\   'left': [ [ 'mode', 'fugitive' ], [ 'readonly', 'filename', 'modified' ] ],
	\   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'inactive': {
	\   'left': [ [ 'readonly', 'filename', 'modified' ] ],
	\   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'component_visible_condition': {
	\   'fugitive': '(exists("*FugitiveHead) && ""!=FugitiveHead()))'
	\ },
	\ 'component_function': {
	\   'modified': 'LightLineModified',
	\   'filename': 'LightLineFilename',
	\   'fileformat': 'LightLineFileformat',
	\   'filetype': 'LightLineFiletype',
	\   'fileencoding': 'LightLineFileencoding',
	\   'fugitive': 'LightlineFugitive',
	\   'readonly': 'LightLineReadonly',
	\ },
	\ }

	let g:lightline.mode_map = {
	\ 'n' : 'N',
	\ 'i' : 'I',
	\ 'R' : 'R',
	\ 'v' : 'V',
	\ 'V' : 'VL',
	\ "\<C-v>": 'VB',
	\ 'c' : 'C',
	\ 's' : 'S',
	\ 'S' : 'SL',
	\ "\<C-s>": 'SB',
	\ 't': 'T',
	\ }

	function! LightlineFugitive()
		if exists('*FugitiveHead')
			let branch = FugitiveHead()
			return branch !=# '' ? ''.branch : ''
		endif
		return ''
	endfunction

	function! LightLineModified()
		return &ft =~ 'help\|qf\|netrw\|fugitiveblame' ? '' : &modified ? '+' : &modifiable ? '' : '-'
	endfunction

	function! LightLineReadonly()
		return &ft !~? 'help\|qf\|netrw\|fugitiveblame' && &readonly ? "\ue0a2" : ''
	endfunction

	function! LightLineFilename()
		let fname = expand('%f')
		return &ft !~? 'qf\|fugitiveblame' ? ('' != fname ? fname : '[No Name]') : ''
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
endif
