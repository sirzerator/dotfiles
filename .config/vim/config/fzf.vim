if exists("g:plugs['fzf']")
	let g:fzf_height = '40%'

	command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
	nnoremap <C-P> :Files<CR>
	nnoremap <leader>ag :Ag<CR>
	nnoremap <space><space>  <C-^>

	let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

	function! s:build_quickfix_list(lines)
	  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
	  copen
	  cc
	endfunction

	let g:fzf_action = {
	  \ 'ctrl-q': function('s:build_quickfix_list'),
	  \ 'ctrl-t': 'tab split',
	  \ 'ctrl-x': 'split',
	  \ 'ctrl-v': 'vsplit' }
endif
