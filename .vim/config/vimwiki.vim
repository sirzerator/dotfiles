if exists("g:plugs['vimwiki']")
	let g:vimwiki_listsyms = ' 123456789X'
	let g:vimwiki_diary_months = {
				\ 1: 'Janvier', 2: 'Février', 3: 'Mars',
				\ 4: 'Avril', 5: 'Mai', 6: 'Juin',
				\ 7: 'Juillet', 8: 'Août', 9: 'Septembre',
				\ 10: 'Octobre', 11: 'Novembre', 12: 'Décembre'
				\ }
	let g:vimwiki_list = [{'path': '~/NextCloud/documents/wiki/', 'auto_diary_index': 1, 'diary_header': 'Journal', 'diary_rel_path': 'journal/', 'diary_index': 'journal', 'diary_frequency': 'weekly', 'diary_start_week_day': 'sunday' }]

	autocmd BufNewFile */journal/*.wiki 0r ~/.vim/templates/journal.skeleton
	autocmd BufEnter */journal/*.wiki setlocal complete=k~/NextCloud/documents/journal/**/*

	autocmd BufEnter */journal/*.wiki iabbrev <buffer> todo ·
	autocmd BufEnter */journal/*.wiki iabbrev <buffer> done ×
	autocmd BufEnter */journal/*.wiki iabbrev <buffer> moved >
	autocmd BufEnter */journal/*.wiki iabbrev <buffer> note -
	autocmd BufEnter */journal/*.wiki iabbrev <buffer> event o

	autocmd BufEnter */journal/*.wiki syntax match JournalDone /^×.*/     " lines containing 'done'  items: ×
	autocmd BufEnter */journal/*.wiki syntax match JournalTodo /^·.*/     " lines containing 'todo'  items: ·
	autocmd BufEnter */journal/*.wiki syntax match JournalEvent /^○.*/    " lines containing 'event' items: ○
	autocmd BufEnter */journal/*.wiki syntax match JournalEventDone /^●.*/    " lines containing 'done event' items: ●
	autocmd BufEnter */journal/*.wiki syntax match JournalNote /^- .*/    " lines containing 'note'  items: -
	autocmd BufEnter */journal/*.wiki syntax match JournalMoved /^>.*/    " lines containing 'moved' items: >

	autocmd ColorScheme * highlight JournalDone   ctermfg=12  " bright black
	autocmd ColorScheme * highlight JournalEvent  ctermfg=6   " cyan
	autocmd ColorScheme * highlight JournalEventDone  ctermfg=4   " blue
	autocmd ColorScheme * highlight JournalMoved  ctermfg=5   " magenta
	autocmd ColorScheme * highlight JournalNote   ctermfg=3   " yellow	
endif
