#================================
#= Misc exports
export PATH=$PATH:$HOME/.local/bin

# Making ls pretty
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Setting term to 256 colours
export TERM=screen-256color

# Setting editor
export EDITOR=vim
#================================
#= PS1 business
function __git_ps1 () {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return 0
	PS_GIT="${ref#refs/heads/}"
	echo -e " \[\033[1;33m\]Ґ $PS_GIT\[\033[m\] \[\033[1;37m\]❯\[\033[m\]"
}

function __suffix_ps1 () {
	[[ "$(pwd)" == "$HOME" ]] && echo -e  "\[\033[1;37m\] \[\033[m\]" || echo -e "\n \[\033[1;37m\]↳\[\033[m\] "
}

function __pyvenv_ps1 () {
	[[ -z $VIRTUAL_ENV ]] && echo -e " " || echo -e " \[\033[1;30m\]$(basename $VIRTUAL_ENV)\[\033[m\] \[\033[1;37m\]❯\[\033[m\] "
}

set_bash_prompt(){
    PS1="$(__pyvenv_ps1)\[\033[1;36m\]\w\[\033[m\] \[\033[1;37m\]❯\[\033[m\]$(__git_ps1)$(__suffix_ps1)"
}

PROMPT_COMMAND=set_bash_prompt
#================================
#= locales
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
#================================
#= FZF magic
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})+abort' --reverse --border=rounded --height ${FZF_TMUX_HEIGHT:-50%}"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash || echo -e "Warning: /usr/share/fzf/key-bindings.bash not found"

#================================
#= Aliases
alias tmux="tmux -2"
alias t="touch"
alias cat='bat'
alias src="source ~/.bashrc"
alias watch="watch -n 5 -d --color"
alias preview="fzf --preview 'bat --color always {}'"
alias man="man -P 'bat --color always'"
alias ack="ack --pager='bat --color always' --colour"
alias ls='ls -GFh'
alias exa='exa --color always --group-directories-first'
alias l='exa --color always --group-directories-first -T -L 1 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias ll='exa --color always --group-directories-first -T -L 2 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias lll='exa --color always --group-directories-first -T -L 3 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias llll='exa --color always --group-directories-first -T -L 4 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
# Alternative
alias l2='exa --color always --group-directories-first -T -L 2 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias l3='exa --color always --group-directories-first -T -L 3 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias l4='exa --color always --group-directories-first -T -L 4 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias l5='exa --color always --group-directories-first -T -L 5 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias l6='exa --color always --group-directories-first -T -L 6 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias l7='exa --color always --group-directories-first -T -L 7 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias l8='exa --color always --group-directories-first -T -L 8 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias l9='exa --color always --group-directories-first -T -L 9 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git'
alias la='exa --color always --group-directories-first -T -L 1 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git -a'
alias lla='exa --color always --group-directories-first -T -L 2 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git -a'
alias llla='exa --color always --group-directories-first -T -L 3 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git -a'
alias lllla='exa --color always --group-directories-first -T -L 4 -l --git -a'
# Showing everything; alternative
alias l2a='exa --color always --group-directories-first -T -L 2 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git -a'
alias l3a='exa --color always --group-directories-first -T -L 3 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git -a'
alias l4a='exa --color always --group-directories-first -T -L 4 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git -a'
alias l5a='exa --color always --group-directories-first -T -L 4 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git -a'
alias l6a='exa --color always --group-directories-first -T -L 4 -I "*.pyc|*pycache*|.git|.idea|.pytest_cache" -l --git -a'
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias gs="git status"
alias gd="git diff"
alias gp="git pull"
alias gb="git branch"
alias master="git checkout master"
