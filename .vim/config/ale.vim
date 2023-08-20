if exists("g:plugs['ale']")
	" phpcs, phpcbf: composer require --dev "squizlabs/php_codesniffer=*"
	" phpstan: composer require --dev phpstan/phpstan
	" phpstan + Laraval: composer require --dev nunomaduro/larastan:^2.0
	let g:ale_linters = {'php': ['php', 'phpcs', 'phpstan'], 'ruby': ['rubocop'], 'go': ['golangci-lint', 'gopls']}
	let g:ale_fixers = {'php': ['phpcbf'], 'ruby': ['rubocop']}

	let g:ale_ruby_rubocop_executable = 'bundle'
	let g:ale_ruby_rubocop_options = '-D'

	nnoremap <leader>FF :ALEFix<CR>

	function! AleHighlights() abort
		highlight ALEVirtualTextWarning guifg=yellow
		highlight ALEVirtualTextInfo guifg=blue
		highlight link ALEVirtualTextStyleError Error
		highlight ALEVirtualTextStyleWarning guifg=yellow
	endfunction

	augroup AleColors
		autocmd!
		autocmd ColorScheme * call AleHighlights()
	augroup END
endif
