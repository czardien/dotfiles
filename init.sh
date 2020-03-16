#!/bin/sh
# ag
echo "ln -sf ~/dotfiles/ag/.agignore ~/.agignore"
ln -sf ~/dotfiles/ag/.agignore ~/.agignore

# bash
echo "echo -e \"\n[ -f ~/dotfiles/bash/.bashrc ] && source ~/dotfiles/bash/.bashrc\" >> ~/.bashrc"
echo -e "\n[ -f ~/dotfiles/bash/.bashrc ] && source ~/dotfiles/bash/.bashrc" >> ~/.bashrc

# termite
echo "mkdir -p ~/.config/termite"
mkdir -p ~/.config/termite
echo "ln -sf ~/dotfiles/termite/config ~/.config/termite/config"
ln -sf ~/dotfiles/termite/config ~/.config/termite/config

# i3
echo "ln -sf ~/dotfiles/i3/config ~/.config/i3/config"
ln -sf ~/dotfiles/i3/config ~/.config/i3/config
echo "ln -sf ~/dotfiles/i3/status.toml ~/.config/i3/status.toml"
ln -sf ~/dotfiles/i3/status.toml ~/.config/i3/status.toml

# picom
echo "mkdir -p ~/.config/picom"
mkdir -p ~/.config/picom
echo "ln -sf ~/dotfiles/picom/picom.conf ~/.config/picom/picom.conf"
ln -sf ~/dotfiles/picom/picom.conf ~/.config/picom/picom.conf

# tmux
echo "ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf"
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

# vim
echo "mkdir -p ~/.vim/backup"
mkdir -p ~/.vim/backup
echo "ln -sf ~/dotfiles/vim/.vimrczero ~/.vimrc"
ln -sf ~/dotfiles/vim/.vimrczero ~/.vimrc
