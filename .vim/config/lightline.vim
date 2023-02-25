if exists("g:plugs['lightline.vim']")
	set laststatus=2

	let g:lightline = {
	\ 'colorscheme': 'jellybeans',
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' },
	\ 'active': {
	\   'left': [ [ 'fugitive' ], [ 'readonly', 'filename', 'modified' ] ],
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
