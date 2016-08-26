" Vim Grepper
if exists("g:plugs['vim-grepper']")
	nnoremap <leader>git :Grepper -tool git -noswitch<cr>
	nnoremap <leader>ag  :Grepper -tool ag  -grepprg ag --vimgrep<cr>
	nnoremap <leader>*   :Grepper -tool ack -cword -noprompt<cr>
endif
