if exists("g:plugs['vim-fugitive']")
	autocmd User FugitiveEditor startinsert

	command! Gvlog :vertical :G log
	command! Glog :G log
endif
