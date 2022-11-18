setlocal noswapfile
set autochdir
set matchtime=2
set magic
set foldenable
set foldmethod=syntax
set foldcolumn=0
setlocal foldlevel=1
nnoremap z<space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " 用空格键来开关折叠
syntax on " Automatic syntax highlighting 
set nocompatible " Turn off vi compatibility mode
set number " Show line number
set cursorline " Highlight current line
set hlsearch " Highlight matched text
set incsearch " Display search results when you enter search content
set t_Co=256 " Open 256 color
set backspace=indent,eol,start " Backspace key can go back to the previous line
set smartindent " smart alignment
set shiftwidth=4 " indent = 2
set softtabstop=4
set tabstop=4
set ignorecase " case insensitive
set laststatus=2 " always display statusline
set tags=tags;/
filetype on " Open file type detection
let mapleader=" " " Set <leader> = <space>

" adjust window
map <UP> <ESC><C-W>-
map <DOWN> <ESC><C-W>+
map <LEFT> <ESC><C-W><
map <Right> <ESC><C-W>>
map <S-UP> <ESC><C-W>5-
map <S-DOWN> <ESC><C-W>5+
map <S-LEFT> <ESC><C-W>5<
map <S-Right> <ESC><C-W>5>

" Pre table
nnoremap <leader>n :tabp<CR> 
" Next table
nnoremap <leader>m :tabn<CR> 
" Close all tables except for current
nnoremap <leader>b :tabo<CR> 
" Close current table
nnoremap <leader>c :tabc<CR> 
" 当esc的时候取消高亮
nnoremap <esc> :nohl<cr>

" Jump to the next match and place it in the center of the screen
nnoremap = nzz
" Jump to the pre match and place it in the center of the screen
nnoremap - Nzz

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

" Path auto Complete
imap <C-F> <C-X><C-F>
" When the completion menu is opened, c-j, k are selected up and down
imap <expr><c-j> pumvisible()?"\<C-N>":"\<C-X><C-O>"
imap <expr><c-k> pumvisible()?"\<C-P>":"\<esc>"

" Arrow key to resize
" map <up> :res +5<CR>
" map <down> :res -5<CR>
" map <left> :vertical resize-5<CR>
" map <right> :vertical resize+5<CR>

" plugin
call plug#begin('~/.vim/plugged')
	" fzf plugin
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	" taglist plugin
	Plug 'yegappan/taglist'
	" nerdtree
	Plug 'preservim/nerdtree'
	" air-line
	Plug 'vim-airline/vim-airline'
	" fugitive
	" Plug 'tpope/vim-fugitive'
	" apc
	Plug 'skywind3000/vim-auto-popmenu'
	Plug 'skywind3000/vim-dict'
	" scheme deus
	Plug 'ajmwagar/vim-deus'
call plug#end()

" fzf configure
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" taglist configure
let Tlist_Ctags_Cmd = '/opt/homebrew/bin/ctags' 
let Tlist_Show_One_File = 1        " Do not display tags of multiple files at the same time, only display the current file
let Tlist_Exit_OnlyWindow = 1      " If the taglist window is the last window, exit vim
let Tlist_Use_Right_Window = 1     " Display the taglist window in the right window
nnoremap <C-d> :! ctags -R *<CR>
nnoremap <C-g> :Tlist<CR>

" scheme
colorscheme deus

" Nerdtree configure
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" start or hidden NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
" Open the existing NERDTree on each new tab.
" autocmd BufWinEnter * silent NERDTreeMirror

" apc
source ~/.vim/apc.vim
" enable this plugin for filetypes, '*' for all files.
let g:apc_enable_ft = {'text':1, 'markdown':1, 'h':1, 'c':1, 'cpp':1, 'sh':1, 'tcl':1, 'python':1}
" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b
" don't select the first item.
set completeopt=menu,menuone,noselect
" suppress annoy messages.
set shortmess+=c
" set relativenumber
" DoxygenToolkit
source ~/.vim/DoxygenToolkit.vim

" Coding
map <C-B> ggVG"+yG
map <F9> :call Run()<CR>
func! Run()
    exec "w"
    exec "!rm -f %<"
    exec "!g++-11 -std=c++20 -Wall % -o %<"
    exec "!./%<"
endfunc

" Bracket completion
" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap { {}<ESC>i
" inoremap < <><ESC>i

"新建.c,.h,.sh文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh :call SetTitle()
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: andif") 
        call append(line(".")+2, "\# mail: fzucwj@gmail.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%Y-%m-%d")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash") 
        call append(line(".")+6, "") 
    else 
        call setline(1, "/**") 
        call append(line("."), " *    author: andif") 
        call append(line(".")+1, " *    created: ".strftime("%d.%m.%Y %T")) 
        call append(line(".")+2, "**/") 
    endif
    if &filetype == 'cpp'
        call append(line(".")+3, "#include<bits/stdc++.h>")
        call append(line(".")+4, "using namespace std;")
        call append(line(".")+5, "")
	    call append(line(".")+6, "#define de(x) cerr << #x << \" = \" << x << endl")
	    call append(line(".")+7, "#define dd(x) cerr << #x << \" = \" << x << \" \"")
	    call append(line(".")+8, "#define rep(i, a, b) for(int i = a; i < b; ++i)")
	    call append(line(".")+9, "#define per(i, a, b) for(int i = a; i > b; --i)")
	    call append(line(".")+10, "#define mt(a, b) memset(a, b, sizeof(a))")
	    call append(line(".")+11, "#define sz(a) (int)a.size()")
	    call append(line(".")+12, "#define fi first")
	    call append(line(".")+13, "#define se second")
	    call append(line(".")+14, "#define qc ios_base::sync_with_stdio(0);cin.tie(0)")
	    call append(line(".")+15, "#define eb emplace_back")
        call append(line(".")+16, "#define all(a) a.begin(), a.end()")
        call append(line(".")+17, "using ll = long long;")
        call append(line(".")+18, "using db = double;")
        call append(line(".")+19, "using pii = pair<int, int>;")
        call append(line(".")+20, "using pdd = pair<db, db>;")
        call append(line(".")+21, "using pll = pair<ll, ll>;")
        call append(line(".")+22, "using vi = vector<int>;")
        call append(line(".")+23, "const db eps = 1e-9;")
        call append(line(".")+24, "")
        call append(line(".")+25, "int main() {")
        call append(line(".")+26, "")
        call append(line(".")+27, "    return 0;")
        call append(line(".")+28, "}")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
		normal 28G
endfunc
