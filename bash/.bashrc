#     .--.              .--.
#    : (\ ". _......_ ." /) :
#     '.    `        `    .'
#      /'   _        _   `\
#     /     0}      {0     \
#    |       /      \       |
#    |     /'        `\     |
#     \   | .  .==.  . |   /
#      '._ \.' \__/ './ _.'
#      /  ``'._-''-_.'``  \


######################
#           DOTFILES #
#                    #
######################

alias dotfiles='cd /home/adrien/.dotfiles/'

######################
#               TERM #
#                    #
######################

export TERM=screen-256color

######################
#               PATH #
#                    #
######################

export PATH=$PATH:$HOME/.local/bin:$HOME/adrien/.npm-global/bin

######################
#            SYSTEMD #
#                    #
######################

export SYSTEMD_PAGER=cat

######################
#                BAT #
#                    #
######################

export BAT_THEME="OneHalfLight"

######################
#                PS1 #
#                    #
######################

# Relevant resources for common issues:
# https://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly
# https://unix.stackexchange.com/questions/11156/re-escape-brackets-in-ps1
# https://stackoverflow.com/questions/6592077/bash-prompt-and-echoing-colors-inside-a-function

function __git_ps1 () {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return 0
	PS_GIT="${ref#refs/heads/}"
	echo -e " \[\033[1;34m\]Ґ $PS_GIT\[\033[m\] \[\033[1;37m\]❯\[\033[m\]"
}

function __kube () {
	ctx=$(kubectl config current-context 2> /dev/null) || return 0 echo -e " \[\033[1;35m\]$ctx\[\033[m\] \[\033[1;37m\]❯\[\033[m\]"
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

######################
#                FZF #
#                    #
######################

# Opening with vim from fzf
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})+abort' --reverse --border=rounded --height ${FZF_TMUX_HEIGHT:-50%}"

# Using ag to search (The Silver Searcher) and showing hidden files
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# From https://github.com/junegunn/fzf#respecting-gitignore
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Setting preview thing with fzf
alias preview="fzf --preview 'bat --color always {}'"

[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash || echo -e "Warning: /usr/share/fzf/key-bindings.bash not found"
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash || echo -e "Warning: /usr/share/fzf/completion.bash not found"

######################
#                X11 #
#                    #
######################

setxkbmap gb

######################
#               TMUX #
#                    #
######################

# Making tmux pick up colours
alias tmux="tmux -2"

# Making tmux start when you say please
alias tmuxplease="tmux new-session -t code"


######################
#          SHORTCUTS #
#                    #
######################

alias t="touch"                          # To touch with fanciness
alias cat='bat'                          # Making bat the default cat
alias src="source ~/.bashrc"             # Making life magical
alias watch="watch -n 5 -d --color"      # Making watch pretty
alias man="man -P 'bat --color always'"  # Making man more handsomer


######################
#                 CD #
#                    #
######################

# Being extra clever to navigate up the directories
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

######################
#                GIT #
#                    #
######################

# Make git awesome
alias gs="git status"
alias gd="git diff"
alias gp="git pull"

# Making git super cool
alias master="git checkout master"

# Make git FZF kind of awesome
function gb() {
  local br
  br=$(git branch | fzf | awk '{printf "%s\n", $2}')
  git checkout "$br"
}

# Go to a repository URL
function gr () {
  local git_url
  [ -d .git ] || echo "Not a git directory"
  [ -d .git ] || return 1
  git_url=https://$(git remote get-url origin | \
	  sed 's/\.git//g' | \
	  sed 's/git\@//g' | \
	  sed 's/-czardien//g' | \  # when setting `czardien` as user to the hostname in ssh config
	  sed 's/-adrien-mg//g' | \  # when setting `adrien-mg` as user to the hostname in ssh config
	  tr ':' '/')
  prgr=firefox
  [ -n $(which python3) ] && prgr="python3 -m webbrowser"
  $prgr $git_url &> /dev/null
}

# Goes over the given directory and looks for modifications in git repositories
function ggotobed () {
  local path allrepos repo proj changes controller
  path=$1
  [ -n "$1" ] || path="."
  allrepos=$(fd --hidden --type d ".git" $path)
  controller=true
  for repo in $allrepos
  do
    proj=$(dirname "$repo")
    changes=$(cd "$proj" && git status --porcelain)
    [ -n "$changes" ] && echo "[ X ][ $(echo "$path/$proj" | tr -s '//' '/') ]"
    [ -n "$changes" ] && controller=false
  done
  [ "$controller" = "true" ] && echo "[ V ] Go to bed!"
}

######################
#             DOCKER #
#                    #
######################

# Make docker awesome
alias dka='dkc;dki;dkv'
alias dkc='docker ps -aq | xargs docker rm -f'
alias dki='docker images -aq | xargs docker rmi -f'
alias dkv='docker volume ls -qf dangling=true | xargs docker volume rm'

######################
#                EXA #
#                    #
######################

# Make use of exa
alias exa='exa --color always --group-directories-first'

# Being clever when using exa
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

# Showing everything
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

######################
#             PYTHON #
#                    #
######################

export PYVENVS=~/.venvs
export PYVENVS_ALIASRC=$PYVENVS/.aliasrc

pyvenv () {
  local name
  name=$1

  [ -d $PYVENVS/$name ] && echo "Virtual environment '$name' already exists at: $PYVENVS/$name" && return 1

  mkdir -p $PYVENVS && \
  python3 -m venv $PYVENVS/$name && \
  echo -e "alias activate-$name='source $PYVENVS/$name/bin/activate'" >> $PYVENVS_ALIASRC

  # echo "PS1=\"\[\033[1;30m\]$name\[\033[m\] \[\033[1;37m\]❯\[\033[m\]\$PS1_BASE\"" >> $PYVENVS/$name/bin/activate
  # echo "export PS1" >> $PYVENVS/$name/bin/activate
}

pyvenv-ls () {
  ls -1 $PYVENVS | sed 's:/*$::'
}

pyvenv-tear () {
  local name
  name=$1

  [ ! -d $PYVENVS/$name ] && echo "Error: virtual environment '$name' not found at: $PYVENVS/$name" && return 1
  rm -rf $PYVENVS/$name

  _alias=$(cat $PYVENVS_ALIASRC | grep "activate-$name")
  [[ -z $_alias ]] && echo "Warning: no alias found for: $name at: $PYVENVS_ALIASRC" || \
          sed -i "/^alias activate-$name/d" $PYVENVS_ALIASRC
}

# Above populates below sourced script
[ -f $PYVENVS_ALIASRC ] && source $PYVENVS_ALIASRC

######################
#                NVM #
#                    #
######################

# Update NPM
alias npmup="npm install -g npm"

# List NPM Global Dependencies
alias npmgl="npm list -g --depth=0"

# Check NPM Global Dependencies for updates
alias npmgo="npm outdated -g --depth=0"

# Update NPM Global Dependencies
alias npmgu="npm update -g --depth=0"

######################
#              CHEAT #
#                    #
######################

export CHEAT_USE_FZF=true

######################
#    BASH COMPLETION #
#                    #
######################

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

######################
#  BASH MAINTAINANCE #
#                    #
######################

# Setting much more appropriate history size limit and file size
export HISTSIZE=10000
export HISTFILESIZE=10000

# Sourcing anything that shouldn't live on a git repo
[[ -f $HOME/.bashrc.secret ]] && source $HOME/.bashrc.secret

# Profiling bash startup (comment)
# If you startup a new Bash session manually (i.e. bash -xl), you can see what is run on login.
#PS4='+ $(date "+%s.%N")\011 '
#set +x
#exec 2>&3 3>&-
