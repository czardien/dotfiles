# For all exports
[ -f ~/dotfiles/.bash/.bash_exports ] && source ~/dotfiles/.bash/.bash_exports

# For fzf key bindings
[ -f ~/dotfiles/.bash/.bash_fzf ] && source ~/dotfiles/.bash/.bash_fzf

# For all things LaTeX
[ -f ~/dotfiles/.bash/.bash_tex ] && source ~/dotfiles/.bash/.bash_tex

# For all aliases
[ -f ~/dotfiles/.bash/.aliasrc ] && source ~/dotfiles/.bash/.aliasrc

# For all functions
[ -f ~/dotfiles/.bash/.bash_funcs ] && source ~/dotfiles/.bash/.bash_funcs

# Profiling bash startup (comment)
# If you startup a new Bash session manually (i.e. bash -xl), you can see what is run on login.
#PS4='+ $(date "+%s.%N")\011 '
#set +x
#exec 2>&3 3>&-
