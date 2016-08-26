" NeoMake
if exists("g:plugs['neomake']")
	autocmd! BufWritePost * Neomake
	let g:neomake_verbose = 0
endif
