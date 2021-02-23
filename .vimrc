syntax enable " Automatic syntax highlighting 
set tabstop=2 " Set table width = 2
set nocompatible " Turn off vi compatibility mode
set number " Show line number
set cursorline " Highlight current line
set hlsearch " Highlight matched text
set incsearch " Display search results when you enter search content
set t_Co=256 " Open 256 color
set backspace=indent,eol,start " Backspace key can go back to the previous line
set autoindent " Automatic alignment
set ignorecase " case insensitive
filetype on " Open file type detection
let mapleader=" " " Set <leader> = <space>
" Pre table
nnoremap <leader>n :tabp<CR> 
" Next table
nnoremap <leader>m :tabn<CR> 
" Close all tables except for current
nnoremap <leader>b :tabo<CR> 
" Close current table
nnoremap <leader>c :tabc<CR> 

" Jump to the next match and place it in the center of the screen
nnoremap = nzz
" Jump to the pre match and place it in the center of the screen
nnoremap - Nzz

" plugin
call plug#begin('~/.vim/plugged')
	" fzf plugin
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	" taglist plugin
	Plug 'yegappan/taglist'
	" YouCompleteMe
	Plug 'Valloric/YouCompleteMe'
	" nerdtree
	Plug 'preservim/nerdtree'
	" air-line
	Plug 'vim-airline/vim-airline'
	" fugitive
	Plug 'tpope/vim-fugitive'
call plug#end()

" fzf configure
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>

" taglist configure
let Tlist_Ctags_Cmd = '/usr/bin/ctags' 
let Tlist_Show_One_File = 1        " Do not display tags of multiple files at the same time, only display the current file
let Tlist_Exit_OnlyWindow = 1      " If the taglist window is the last window, exit vim
let Tlist_Use_Right_Window = 1     " Display the taglist window in the right window
nnoremap <F2> :! ctags -R *<CR>
nnoremap <F3> :Tlist<CR>

" YouCompleteMe configure
" Configure default conf.py path
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/ycmd/tests/clangd/testdata/extra_conf/.ycm_extra_conf.py'
" 打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf=0
set completeopt=longest,menu
" 是否开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
" 是否在注释中也开启补全
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 开始补全的字符数
let g:ycm_min_num_of_chars_for_completion=2
" 补全后自动关机预览窗口
let g:ycm_autoclose_preview_window_after_completion=1
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 字符串中也开启补全
let g:ycm_complete_in_strings = 1
" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 映射按键,没有这个会拦截掉tab, 导致其他插件的tab不能用.
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
" 回车即选中当前项
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" 上下左右键行为
inoremap <expr> <Down>     pumvisible() ? '\<C-n>' : '\<Down>'
inoremap <expr> <Up>       pumvisible() ? '\<C-p>' : '\<Up>'
inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
inoremap <expr> <PageUp>   pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'

" scheme
colorscheme onedark

" Nerdtree configure
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" start or hidden NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror
