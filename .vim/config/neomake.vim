" NeoMake
if exists("g:plugs['neomake']")
	call neomake#configure#automake('w')
	let g:neomake_verbose = 0

	" Python
	let g:neomake_python_flake8_maker = {
	    \ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
	    \ 'errorformat':
	        \ '%E%f:%l: could not compile,%-Z%p^,' .
	        \ '%A%f:%l:%c: %t%n %m,' .
	        \ '%A%f:%l: %t%n %m,' .
	        \ '%-G%.%#',
	    \ }
	let g:neomake_python_enabled_makers = ['flake8']

	" Rust
	let g:neomake_rust_enabled_makers = ['rustc']
endif
