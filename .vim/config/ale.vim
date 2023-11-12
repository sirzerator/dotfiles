if exists("g:plugs['ale']")
	" phpcs, phpcbf: composer require --dev "squizlabs/php_codesniffer=*"
	" phpstan: composer require --dev phpstan/phpstan
	" phpstan + Laravel: composer require --dev nunomaduro/larastan:^2.0
	"let g:ale_linters = {'php': ['php', 'phpcs', 'phpstan'], 'ruby': ['rubocop'], 'go': [], 'rust': ['rustfmt']}
	"let g:ale_fixers = {'php': ['phpcbf'], 'ruby': ['rubocop'], 'go': [], 'rust': ['rustfmt']}

	let g:ale_ruby_rubocop_executable = 'bundle'
	let g:ale_ruby_rubocop_options = '-D'

	let g:ale_cursor_detail = 1
	let g:ale_close_preview_on_insert = 1

	let g:ale_set_highlights = 1
	let g:ale_sign_column_always = 1

	let g:ale_detail_to_preview = 1
	let g:ale_floating_preview = 1
	let g:ale_hover_to_preview = 1

	let g:ale_echo_cursor = 0

	nnoremap <leader>aj :ALENext<cr>
	nnoremap <leader>ak :ALEPrevious<cr>
	nnoremap <leader>ap :ALEPopulateLocList<cr>

	function! AleHighlights() abort
		highlight ALEError guifg=red cterm=underline
		highlight ALEWarning guifg=yellow cterm=underline
		highlight ALEVirtualTextWarning guifg=yellow
		highlight ALEVirtualTextError guifg=red
		highlight link ALEInfoSign Todo
		highlight ALEWarningSign guifg=black guibg=gold
	endfunction

	augroup AleColors
		autocmd!
		autocmd ColorScheme * call AleHighlights()
	augroup END
endif
