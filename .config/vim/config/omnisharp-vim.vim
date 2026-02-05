if exists("g:plugs['omnisharp-vim']")
	let g:OmniSharp_server_use_net6 = 1
	let g:OmniSharp_popup_position = 'peek'

	let g:OmniSharp_popup_options = {
	\ 'highlight': 'Normal',
	\ 'padding': [0],
	\ 'border': [1],
	\ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
	\ 'borderhighlight': ['ModeMsg']
	\}

	let g:OmniSharp_popup_mappings = {
	\ 'sigNext': '<C-n>',
	\ 'sigPrev': '<C-p>',
	\ 'pageDown': ['<C-f>', '<PageDown>'],
	\ 'pageUp': ['<C-b>', '<PageUp>']
	\}

	let g:OmniSharp_highlight_groups = {
	\ 'ExcludedCode': 'NonText'
	\}
endif
