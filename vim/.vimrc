"   .'"'.        ___,,,___        .'``.
"  : (\  `."'"```         ```"'"-'  /) ;
"   :  \                         `./  .'
"    `.                            :.'
"      /        _         _        \
"     |         0}       {0         |
"     |         /         \         |
"     |        /           \        |
"     |       /             \       |
"      \     |      .-.      |     /
"       `.   | . . /   \ . . |   .'
"         `-._\.'.(     ).'./_.-'
"             `\'  `._.'  '/'
"               `. --'-- .'
"                 `-...-'                ~ Hi!
"
"
" Create backup directory
" mkdir -p ~/.vim/backup
"
" Install Plug
" [ -e ~/.vim/autoload/plug.vim ] || curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Install Vundle
" [ -e ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" Install Pathogen
" [ -e ~/.vim/autoload/pathogen.vim ] || curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

" Get those colors!
" mkdir -p ~/.vim/colors && [ -e ~/.vim/colors/onehalflight.vim ] || wget https://raw.githubusercontent.com/sonph/onehalf/master/vim/colors/onehalflight.vim -O ~/.vim/colors/onehalflight.vim
" mkdir -p ~/.vim/colors && [ -e ~/.vim/colors/onehalfdark.vim ] || wget https://raw.githubusercontent.com/sonph/onehalf/master/vim/colors/onehalfdark.vim -O ~/.vim/colors/onehalfdark.vim
"
" Init Vundle
" :PluginInstall
"
" Init Plug
" :PlugInstall

""""""""""""""""""""""
"            PLUGINS "
"                    "
""""""""""""""""""""""

" Maybe needed
set nocompatible

" Vundle; turning filetype off is necessary, we however turn it on again
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle
Plugin 'gmarik/Vundle.vim'
" Use LightLine
Plugin 'itchyny/lightline.vim'
call vundle#end()

filetype plugin indent on
filetype plugin on
filetype on

" Plug thing
call plug#begin()
" FZF
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
" Ale
Plug 'dense-analysis/ale'
" Rust
Plug 'rust-lang/rust.vim'
" jq
Plug 'bfrg/vim-jqplay'
call plug#end()

" Pathogen thing
execute pathogen#infect()

""""""""""""""""""""""
"             LEADER "
"                    "
""""""""""""""""""""""

" Leader key
let mapleader=" "

""""""""""""""""""""""
"             SYNTAX "
"                    "
""""""""""""""""""""""

" Enable syntax checking
syntax enable

""""""""""""""""""""""
"                ALE "
"                    "
""""""""""""""""""""""

let b:ale_fixers = {'sql': ['sqlint'], 'javascript': ['eslint'], 'typescript': ['eslint']}
let g:ale_linters = {
\   'sql': ['sqlint'],
\   'javascript': ['eslint'],
\   'typescript': ['sqlint'],
\   'python': ['flake8', 'mypy']
\}
let g:ale_linters_explicit = 1

""""""""""""""""""""""
"          LIGHTLINE "
"                    "
""""""""""""""""""""""

" Fix no display of status
set laststatus=2

""""""""""""""""""""""
"       COLOR SCHEME "
"                    "
""""""""""""""""""""""

" Set terminal color
set t_Co=256

" Set cursor as a line
set cursorline

" Set colorscheme!
colorscheme onehalfdark

" Set lightline colorscheme!
let g:lightline = { 'colorscheme': 'onehalfdark' }

""""""""""""""""""""""
"                FZF "
"                    "
""""""""""""""""""""""

" Make use of beautiful fzf
nnoremap <C-p> :Files<Cr>
nnoremap <C-b> :Buffers<Cr>

""""""""""""""""""""""
"            DISPLAY "
"                    "
""""""""""""""""""""""

" Display line number
set nu

" Make the new window appear below the current window
set splitbelow
" Make the new window appear on the right
set splitright

""""""""""""""""""""""
"           RUST VIM "
"                    "
""""""""""""""""""""""

" To run rustfmt on save
let g:rustfmt_autosave = 1

""""""""""""""""""""""
"             SEARCH "
"                    "
""""""""""""""""""""""

" Making search prettier
set hlsearch

""""""""""""""""""""""
"          BACKSPACE "
"                    "
""""""""""""""""""""""

" To get a nice backspace key that deletes over line breaks and indents
set backspace=indent,eol,start

""""""""""""""""""""""
"                GUI "
"                    "
""""""""""""""""""""""

" Make sure to escape the spaces in the name properly
set guifont=Source\ Code\ Pro\ for\ Powerline

""""""""""""""""""""""
"       MAINTAINANCE "
"                    "
""""""""""""""""""""""

" Nasty tab business
set tabstop=2
set shiftwidth=2
set expandtab

" Encoding business
set encoding=utf-8

" Ensures all Swap files end up in the same place; we don't pollute our
" projects
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" Put all viminf files under ~/.vim/
set viminfo+=n~/.vim/viminfo

" To make use of the system clipboard
set clipboard=unnamed

" Automatic triming of trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e

" Redo action (instead of Ctrl-r)
nnoremap U <C-R>

" To disable search highlight using CTRL + o
nnoremap <silent> <C-l> :nohl<CR><C-l>

" For making enter inserting a newline
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" If Lightline is activated we don't need to see the double 'INSERT' at the
" bottom
set noshowmode
