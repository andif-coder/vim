syntax on " Automatic syntax highlighting 
set tabstop=4 " Set table width = 4
set nocompatible " Turn off vi compatibility mode
set number " Show line number
set cursorline " Highlight current line
set hlsearch " Highlight matched text
set incsearch " Display search results when you enter search content
" set t_Co=256 " Open 256 color
set backspace=indent,eol,start " Backspace key can go back to the previous line
set autoindent " Automatic alignment
set ignorecase " case insensitive


" ==================================
" Begin set color
" ==================================
syntax enable
set background=light
let g:solarized_termcolors=256
colorscheme solarized
" ==================================
" End set color
" ==================================

" ==================================
" Begin set statusline
" ==================================
" :h mode() to see all modes
let g:currentmode={
	\ 'n'      : 'N ',
	\ 'no'     : 'N¡-Operator Pending ',
	\ 'v'      : 'V ',
	\ 'V'      : 'V-Line ',
	\ '\<C-V>' : 'V-Block ',
	\ 's'      : 'Select ',
	\ 'S'      : 'S-Line ',
	\ '\<C-S>' : 'S-Block ',
	\ 'i'      : 'I ',
	\ 'R'      : 'R ',
	\ 'Rv'     : 'V-Replace ',
	\ 'c'      : 'Command ',
	\ 'cv'     : 'Vim Ex ',
	\ 'ce'     : 'Ex ',
	\ 'r'      : 'Prompt ',
	\ 'rm'     : 'More ',
	\ 'r?'     : 'Confirm ',
	\ '!'      : 'Shell ',
	\ 't'      : 'Terminal '
\}

function! Getcurrentmode()
	if (get(g:currentmode, mode(), '') == '')
		return 'V-Block'
	endif
	return get(g:currentmode, mode(), '')
endfunction

" Automatically change the statusline color depending on mode
function! ChangeStatuslineColor()
	if (mode() =~# '\v(n|no)')
  		exe 'hi! StatusLine ctermfg=002'
	elseif (mode() =~# '\v(v|V)' || Getcurrentmode() ==# 'V-Block' || get(g:currentmode, mode(), '') ==# 't')
		exe 'hi! StatusLine ctermfg=005'
	elseif (mode() ==# 'i')
		exe 'hi! StatusLine ctermfg=004'
	else
		exe 'hi! StatusLine ctermfg=006'
	endif
	return ''
endfunction
" Find out current buffer's size and output it.
function! FileSize()
	let bytes = getfsize(expand('%:p'))
	if (bytes >= 1024)
		let kbytes = bytes / 1024
	endif
	if (exists('kbytes') && kbytes >= 1000)
		let mbytes = kbytes / 1000
	endif
	if bytes <= 0
		return '0'
	endif
	if (exists('mbytes'))
		return mbytes . 'MB '
	elseif (exists('kbytes'))
		return kbytes . 'KB '
	else
		return bytes . 'B '
	endif
endfunction

function! ReadOnly()
	if &readonly || !&modifiable
		return '[RO]'
	else
		return ''
endfunction


set laststatus=2                                         " Always show status line
set statusline=
set statusline+=%{ChangeStatuslineColor()}               " Changing the statusline color
set statusline+=%0*\ %{toupper(Getcurrentmode())}   " Current mode
set statusline+=%8*\ [%n]                                " buffernr
set statusline+=%8*\ %<%F%{ReadOnly()}%m\ %w\        " File+path
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%9*\ %=                                  " Space
set statusline+=%8*\ %y\                                 " FileType
set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ " Encoding & Fileformat
set statusline+=%8*\ %-3(%{FileSize()}%)                 " File size
set statusline+=%0*\ %3p%%\ \ %l:\ %3c\                 " Rownumber/total (%)
" hi User1 ctermfg=007
" hi User2 ctermfg=008
" hi User3 ctermfg=008
" hi User4 ctermfg=008
" hi User5 ctermfg=008
" hi User7 ctermfg=008
" hi User8 ctermfg=008
" hi User9 ctermfg=007
" ==================================
" End set statusline
" ==================================
