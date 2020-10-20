#!/bin/bash
# Create backup directory
mkdir -p ~/.vim/backup

# Install Plug
[ -e ~/.vim/autoload/plug.vim ] || curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Vundle
[ -e ~/.vim/bundle/Vundle.vim ] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Pathogen
[ -e ~/.vim/autoload/pathogen.vim ] || curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install Syntastic
[ -e ~/.vim/bundle/syntastic.git ] || git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic.git

# Get those colors!
mkdir -p ~/.vim/colors && [ -e ~/.vim/colors/onehalflight.vim ] || wget https://raw.githubusercontent.com/sonph/onehalf/master/vim/colors/onehalflight.vim -O ~/.vim/colors/onehalflight.vim
mkdir -p ~/.vim/colors && [ -e ~/.vim/colors/onehalfdark.vim ] || wget https://raw.githubusercontent.com/sonph/onehalf/master/vim/colors/onehalfdark.vim -O ~/.vim/colors/onehalfdark.vim
