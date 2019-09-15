# set -o vi

# To use Ctrl+L to clear the screen in insert and normal mode
# https://unix.stackexchange.com/questions/104094/is-there-any-way-to-enable-ctrll-to-clear-screen-when-set-o-vi-is-set
# bind -m vi-insert "\C-l":clear-screen

# To use tmuxinator
export EDITOR=vim
source ~/.tmuxinator.bash

# To use go
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# Opening with vim from fzf
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})+abort'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git --exclude .swp --exclude Library"

# Making ls pretty
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setting term to 256 colours
export TERM=screen-256color

# For fzf key bindings
[ -f ~/.bash_fzf ] && source ~/.bash_fzf

# For all things LaTeX
[ -f ~/.bash_tex ] && source ~/.bash_tex

# For all aliases
[ -f ~/.aliasrc ] && source ~/.aliasrc

# For all functions
[ -f ~/.bashfuncs ] && source ~/.bashfuncs

# Profiling bash startup (comment)
# If you startup a new Bash session manually (i.e. bash -xl), you can see what is run on login.
#PS4='+ $(date "+%s.%N")\011 '
#set +x
#exec 2>&3 3>&-
