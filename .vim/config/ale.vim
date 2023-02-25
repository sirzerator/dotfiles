if exists("g:plugs['ale']")
	" phpcs, phpcbf: composer require --dev "squizlabs/php_codesniffer=*"
	let g:ale_linters = {'php': ['php', 'phpcs']}
	let g:ale_fixers = {'php': ['phpcbf']}

	let g:ale_php_phpcs_executable='./vendor/bin/phpcs'

	let g:ale_php_phpcbf_executable='./vendor/bin/phpcbf'

	nnoremap <leader>FF :ALEFix<CR>
endif
