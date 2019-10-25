set nocompatible

" vundle: use setup the plugins
filetype off

"let g:vundle_default_git_proto = 'git'
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'YorickPeterse/happy_hacking.vim'
Plugin 'ervandew/supertab'
Plugin 'vhda/verilog_systemverilog.vim'
Plugin 'godlygeek/tabular'
Plugin 'ctrlpvim/ctrlp.vim'
call vundle#end()

" Remove ex mode
map Q <Nop>

" map leader to , (easier than backslash, and more portable)
let mapleader = ","


filetype plugin indent on

autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType c setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType tcl setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
autocmd BufRead,BufNewFile *.sh setlocal ts=4 sts=4 sw=4 expandtab
autocmd BufRead,BufNewFile *.sv{,h,.mds} setfiletype systemverilog
autocmd FileType verilog_systemverilog setlocal ts=2 sts=2 sw=2 expandtab

" ASL highlight for .asl/.aslh files
autocmd BufRead,BufNewFile *.as{l,h} source ~/.vim/asl.vim
" Remove any trailing whitespace that is in the file
autocmd BufWritePost * if ! &bin | silent! %s/\s\+$//ge | endif
" Set json to get highlight like js
autocmd BufRead,BufNewFile *.json setfiletype javascript
" bash syntax for dot*shrc files
autocmd BufReadPost dotc?shrc set syntax=bash

set relativenumber
set number
syntax on
set encoding=utf-8
set linebreak
set background=dark
color happy_hacking

set splitbelow
set splitright

set ruler

" auto expand tabs for python and haskell
autocmd FileType python set expandtab
autocmd FileType haskell set expandtab
autocmd FileType tcl set expandtab
autocmd FileType yaml set expandtab

" Run python with <leader> r
autocmd BufRead *.py noremap <leader>r :w<CR> :!python3 %<CR>
" Comment line (python #) using ,c
autocmd BufRead *.py noremap <leader>c I# 

" Comment line (C-style //) using ,c
autocmd BufRead *.h,*.c,*.cpp,*.js,*.java,*.sv,*.svh,*.sv.mds,*.vc  noremap <leader>c I// 

" Run make with ,m and immediately hide the shell
nnoremap <leader>m :silent make\|redraw!\|cc<CR>

" Update faster gitgutter
set updatetime=250

" Completion option
set completeopt=menuone
let g:SuperTabDefaultCompletionType = "<c-n>"

" Backspace goes trough indent, eol, ...
set backspace=indent,eol,start

" Go to ctags stuff with ctrl + l
map <C-l> <C-]>
" Search tags in higher directories
set tags=tags;/

noremap <Leader>y "*y
noremap <Leader>p "*p

" in gvim
if !has('gui_running')
	" highlight current line
	set cursorline
endif

" Mouse in normal mode only
set mouse=n
set ttymouse=xterm2

" Don't drag with mouse - no visual mode
noremap <LeftDrag> <LeftMouse>
noremap! <LeftDrag> <LeftMouse>


" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Clear previous search buffer on vim opening
" let @/ = ""

" Set a sexy title
set title

" Search: ignore case unless there is an upper case in the search term
set ignorecase
set smartcase
" Search starts as soon as you type
set incsearch
" highlight search results
set hlsearch

" Show current file at the bottom
set ls=2

set backupdir=~/.vim/tmp,.
set directory=~/.vim/swaps,.
set undodir=~/.vim/undo,.

" :commands completions
set wildmenu
set wildmode=longest,list,full

set autoindent

" Remap 0 to first non-blank character of the line
map 0 ^


" search will center on the line the result is found
nmap <silent> n nzz
nmap <silent> N Nzz

set titleold=

" Fit quickfix window height to # of element (with a max of 6)
au FileType qf call AdjustWindowHeight(3, 6)
function! AdjustWindowHeight(minheight, maxheight)
	exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Go to next error with ,n and previous with ,p
noremap <leader>n :lnext<CR>
noremap <leader>p :lprevious<CR>
" Close quickfix with ,C
noremap <leader>C :lclose<CR>


" gvim font
set guifont=Monospace\ 15
" remove stupid gvim top bars
set guioptions -=T
set guioptions -=m

" Function to trim the whitespace at the end of lines
fun! TrimWhitespace()
	let l:save = winsaveview()
	%s/\s\+$//e
    call winrestview(l:save)
endfun

" Call it with :TrimWhitespace
command! TrimWhitespace call TrimWhitespace()

" :Vexplore, Sexplore, Explore with tree view
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 3
let g:netrw_winsize = 12


runtime macros/matchit.vim

set exrc
set secure
