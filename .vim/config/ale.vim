if exists("g:plugs['ale']")
	" phpcs, phpcbf: composer require --dev "squizlabs/php_codesniffer=*"
	" phpstan: composer require --dev phpstan/phpstan
	" phpstan + Laraval: composer require --dev nunomaduro/larastan:^2.0
	let g:ale_linters = {'php': ['php', 'phpcs', 'phpstan'], 'ruby': ['rubocop']}
	let g:ale_fixers = {'php': ['phpcbf'], 'ruby': ['rubocop']}

	let g:ale_ruby_rubocop_executable = 'bundle'
	let g:ale_ruby_rubocop_options = '-D'

	nnoremap <leader>FF :ALEFix<CR>
endif
