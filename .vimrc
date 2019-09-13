set encoding=utf-8

" Display line number
set nu

" Make the new window appear below the current window
set splitbelow
" Make the new window appear on the right
set splitright

" Almost useless; makes sure you enable ViM functionality
" https://superuser.com/questions/543317/what-is-compatible-mode-in-vim
set nocompatible

" Ensures all Swap files end up in the same place; we don't pollute our
" projects
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/

" For folding
set foldmethod=indent
set foldlevel=99

" To make use of the system clipboard
set clipboard=unnamed

" To get a nice backspace key that deletes over line breaks and indents
set backspace=indent,eol,start

" Making search prettier
set hlsearch

" Make sure to escape the spaces in the name properly
set guifont=Source\ Code\ Pro\ for\ Powerline

" Vundle thing; turning filetype off is necessary, we however turn it on again
filetype off

set rtp+=/Users/adrien/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" Makes sure the folding is seamless
Plugin 'tmhedberg/SimpylFold'
" Zenburn Color scheme
Plugin 'jnurmine/Zenburn'
" Solarized Color scheme
Plugin 'altercation/vim-colors-solarized'
" For some nice NERDTree action
Plugin 'scrooloose/nerdtree'
" For Git integration
Plugin 'tpope/vim-fugitive'
" To integrate my favourite searching tool
Plugin 'mileszs/ack.vim'
" To automatically generate Table of Contents in Markdown files
Plugin 'mzlogin/vim-markdown-toc'

" For auto-complete; uses Jedi auto-completer and some C libraries
" Bundle 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on
filetype plugin on
filetype on

" Plug thing
call plug#begin()

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'

" Go things https://github.com/fatih/vim-go-tutorial
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'fatih/molokai'

" Javascript things https://github.com/pangloss/vim-javascript
Plug 'pangloss/vim-javascript'

" HTML Things
" https://medium.com/vim-drops/be-a-html-ninja-with-emmet-for-vim-feee15447ef1
Plug 'mattn/emmet-vim'

" Polyglot thing :scream: https://freshman.tech/vim-javascript/
Plug 'sheerun/vim-polyglot'

call plug#end()

execute pathogen#infect()

" ================================
" Color schemes action right there

" set background=dark
" colorscheme solarized

" colorscheme zenburn

" let g:rehash256 = 1
" let g:molokai_original = 1
" colorscheme molokai
" ================================

" Automatic triming of trailing whitespaces
autocmd BufWritePre * %s/\s\+$//e

" Leader key
let mapleader=" "

" Redo action (instead of Ctrl-r)
nnoremap U <C-R>

" Make use of awesome fzf
nnoremap <C-p> :Files<Cr>
nnoremap <C-b> :Buffers<Cr>

" To disable search highlight using CTRL + o
nnoremap <c-o> <c-o>:noh<cr>

" For making enter inserting a newline
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
