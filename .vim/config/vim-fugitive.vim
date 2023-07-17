if exists("g:plugs['vim-fugitive']")
	"autocmd User FugitiveEditor startinsert

	command! Gvl :vertical :G log -n1000
	command! Gvlog :vertical :G log -n1000
	command! Gl :G log -n1000
	command! Glog :G log -n1000
endif
