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
#

######################
#             EDITOR #
#                    #
######################

export EDITOR=vim

######################
#              UTILS #
#                    #
######################

alias aur='cd /home/adrien/.aur/'
alias vimrc='vim /home/adrien/.dotfiles/vim/.vimrc'
alias bashrc='vim /home/adrien/.dotfiles/bash/.bashrc'
alias dotfiles='cd /home/adrien/.dotfiles/'
alias systemd-unit-files='cd /home/adrien/.systemd-unit-files/'

######################
#         EXCALIDRAW #
#                    #
######################

alias draw="docker stop excalidraw >/dev/null 2>&1 && docker run --rm -dit --name excalidraw -p 5000:80 excalidraw/excalidraw:latest >/dev/null 2>&1 && firefox http://localhost:5000"

######################
#              NOTES #
#                    #
######################

NOTES_HOME=$HOME/.notes
alias notes='cd $NOTES_HOME'

function notes() {
  local note
  cd $NOTES_HOME
  note=$(find . -type f -name "*note*" | \
    sed 's/^\.\///g' | \
    fzf --preview 'bat --color always {}')
  $EDITOR $note
  cd - > /dev/null
}

function cards() {
  local card
  cd $NOTES_HOME
  card=$(find . -type f -name "*card*" | \
    sed 's/^\.\///g' | \
    fzf --preview 'bat --color always {}')
  $EDITOR $card
  cd - > /dev/null
}

function gist() {
  local gist copy
  copy=false
  cd $NOTES_HOME
  # check arguments
  if [[ $# == 1 ]]; then
    if [[ ! $1 == -c ]]; then
      echo "error: argument $1 not recognised"
      echo ""
      echo "usage: gist [-c]"
      echo "options: -c"
      echo "          Copies content of gist to clipboard"
      return 1
    else
      copy=true
    fi
  fi
  # find files
  gist=$(find . -type f -name "*gist*" | \
    sed 's/^\.\///g' | \
    fzf --preview 'bat --color always {}')
  # open or copy
  if [[ $copy == "true" ]]; then
    cat $gist | xclip -sel clip
    echo "'$gist' copied to clipboard"
  else
    $EDITOR $gist
  fi
  cd - > /dev/null
}

######################
#       DOTENV FILES #
#                    #
######################

function load_dotenv() {
  if [[ -f "./.env" ]]
  then
    set -o allexport; source "./.env"; set +o allexport
  fi
}

######################
#               TERM #
#                    #
######################

export TERM=screen-256color

######################
#           SHUTDOWN #
#                    #
######################

alias shutdown-after-update="sudo pacman -Syu && shutdown now"

######################
#               PATH #
#                    #
######################

# local
export PATH=$PATH:$HOME/.local/bin
# gem
export PATH=$PATH:$HOME/.gem/ruby/2.7.0/bin
# asdf
. /opt/asdf-vm/lib/asdf.sh

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
export BAT_THEME="TwoDark"

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
    PS1="$(__pyvenv_ps1)\[\033[1;35m\]\h\[\033[m\] \[\033[1;37m\]❯\[\033[m\] \[\033[1;36m\]\w\[\033[m\] \[\033[1;37m\]❯\[\033[m\]$(__git_ps1)$(__suffix_ps1)"
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
#             SINGER #
#                    #
######################

[ -f ~/.local/usr/share/bash-completion/singer ] && source ~/.local/usr/share/bash-completion/singer 2>/dev/null

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
alias gp="git pull"
alias gd="git diff"
alias gl="git log"
alias glog="git log --oneline | fzf --multi --preview 'git show {+1}'"
alias glog20="git log --oneline -20"

# Making git super cool
alias master="git checkout master"

# See diff with master
function gdmaster() {
  git diff master..$(git rev-parse --abbrev-ref HEAD)
}

# Make git FZF kind of awesome but is broken really
function gb() {
  local br
  br=$(git branch | fzf | awk '{printf "%s\n", $1}')
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
	  # when setting `czardien` as user to the hostname in ssh config
	  sed 's/-czardien//g' | \
	  # when setting `adrien-mg` as user to the hostname in ssh config
	  sed 's/-adrien-mg//g' | \
	  tr ':' '/')
  prgr=firefox
  [ -n $(which python3) ] && prgr="python3 -m webbrowser"
  $prgr $git_url &> /dev/null
}

######################
#             DOCKER #
#                    #
######################

# Make docker awesome
alias dka='dkc && dki && dkv'
alias dkc='docker ps -aq | xargs docker rm -f'
alias dki='docker images -aq | xargs docker rmi -f'
alias dkv='docker volume ls -qf dangling=true | xargs docker volume rm'

######################
#                EXA #
#                    #
######################

# Make use of exa
EXA_IGNORE_BLOB="*.pyc|*pycache*|.git|.idea|.pytest_cache|node_modules|.venv"
EXA_OPTIONS="--color always --group-directories-first -T -I \"$EXA_IGNORE_BLOB\" -l --git"

# Being clever when using exa
alias l="exa $EXA_OPTIONS -L 1"
alias ll="exa $EXA_OPTIONS -L 2"
# Alternative
alias l1="exa $EXA_OPTIONS -L 1"
alias l2="exa $EXA_OPTIONS -L 2"
alias l3="exa $EXA_OPTIONS -L 3"
alias l4="exa $EXA_OPTIONS -L 4"
alias l5="exa $EXA_OPTIONS -L 5"

# Showing everything
alias la="exa $EXA_OPTIONS -L 1 -a"
alias lla="exa $EXA_OPTIONS -L 2 -a"
# Showing everything; alternative
alias l1a="exa $EXA_OPTIONS -L 1 -a"
alias l2a="exa $EXA_OPTIONS -L 2 -a"
alias l3a="exa $EXA_OPTIONS -L 3 -a"
alias l4a="exa $EXA_OPTIONS -L 4 -a"
alias l5a="exa $EXA_OPTIONS -L 5 -a"

# Watch current working directory with exa
alias wcwd="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 1'"
alias wcwd2="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 2'"
alias wcwd3="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 3'"
alias wcwd4="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 4'"
alias wcwd5="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 5'"

alias wcwda="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 1 -a'"
alias wcwd2a="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 2 -a'"
alias wcwd3a="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 3 -a'"
alias wcwd4a="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 4 -a'"
alias wcwd5a="watch -n 0.1 -t -d --color 'exa $EXA_OPTIONS -L 5 -a'"

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

# Lazy loading nvm
function load_nvm () {
	[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh
}

if ! command -v nvm &> /dev/null
then
	function nvm () {
    load_nvm
    nvm "$@"
	}
fi

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
#   DAY / NIGHT MODE #
#                    #
######################

function nightmode () {
	# bat colors
	sed --follow-symlinks -i 's/export BAT_THEME="OneHalfLight"/export BAT_THEME="TwoDark"/g' $HOME/.vimrc
	# vim colors
	sed --follow-symlinks -i 's/colorscheme onehalflight/colorscheme onehalfdark/g' $HOME/.vimrc
	# termite colors
	cat $HOME/.dotfiles/termite/base > $HOME/.dotfiles/termite/config && \
		cat $HOME/.dotfiles/termite/base16-one-dark.config >> $HOME/.dotfiles/termite/config

	# reload termite
	killall -USR1 termite
	# reload bash session
	source ~/.bashrc
}

function daymode () {
	# TODO: gitconfig colors
  # bat colors
	sed --follow-symlinks -i 's/export BAT_THEME="TwoDark"/export BAT_THEME="OneHalfLight"/g' $HOME/.vimrc
	# vim colors
	sed --follow-symlinks -i 's/colorscheme onehalfdark/colorscheme onehalflight/g' $HOME/.vimrc
	# termite colors
	cat $HOME/.dotfiles/termite/base > $HOME/.dotfiles/termite/config && \
		cat $HOME/.dotfiles/termite/base16-one-light.config >> $HOME/.dotfiles/termite/config

	# reload termite
	killall -USR1 termite
	# reload bash session
	source ~/.bashrc
}

######################
#        EXPERIMENTS #
#                    #
######################

alias clip="xclip -sel clip"

function dirmark() {
  DIRMARK=$(pwd)
}

function cdmark(){
  [[ -z $DIRMARK ]] || cd $DIRMARK
}

function fdd() {
  find . -type d -name "*$1*"
}

function fdf() {
  find . -type f -name "*$1*"
}

function previewdir() {
  local dirname
  dirname=$1
  echo $dirname
  ls -1 $dirname | fzf --preview 'bat --color always $dirname/{}'
}

######################
#  BASH MAINTAINANCE #
#                    #
######################

# Setting much more appropriate history size limit and file size
export HISTSIZE=10000
export HISTFILESIZE=10000

# Sourcing anything that shouldn't live on a git repo
[[ -f $HOME/.bashrc.secret ]] && source $HOME/.bashrc.secret

######################
#     BASH PROFILING #
#                    #
######################

# If you startup a new Bash session manually (i.e. bash -xl), you can see what is run on login.
# PS4='+ $(date "+%s.%N")\011 '
# set +x
# exec 2>&3 3>&-
