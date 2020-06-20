# For all exports
[ -f ~/dotfiles/bash/.bash_exports ] && source ~/dotfiles/bash/.bash_exports || echo -e "Warning: ~/dotfiles/bash/.bash_exports not found"

# For all exports
[ -f ~/dotfiles/bash/.bash_ps1 ] && source ~/dotfiles/bash/.bash_ps1 || echo -e "Warning: ~/dotfiles/bash/.bash_ps1 exports not found"

# For anything dependant on the X server
[ -f ~/dotfiles/bash/.bash_x11 ] && source ~/dotfiles/bash/.bash_x11 || echo -e "Warning: ~/dotfiles/bash/.bash_x11 not found"

# For fzf key bindings
[ -f ~/dotfiles/bash/.bash_fzf ] && source ~/dotfiles/bash/.bash_fzf || echo -e "Warning: ~/dotfiles/bash/.bash_fzf not found"

# For all things LaTeX
[ -f ~/dotfiles/bash/.bash_tex ] && source ~/dotfiles/bash/.bash_tex || echo -e "Warning: ~/dotfiles/bash/.bash_tex not found"

# For all aliases
[ -f ~/dotfiles/bash/.aliasrc ] && source ~/dotfiles/bash/.aliasrc || echo -e "Warning: ~/dotfiles/bash/.aliasrc not found"

# Sourcing local aliasrc
[[ -f $HOME/.local/.aliasrc ]] && source $HOME/.local/.aliasrc

# For all functions
[ -f ~/dotfiles/bash/.bash_funcs ] && source ~/dotfiles/bash/.bash_funcs || echo -e "Warning: ~/dotfiles/bash/.bash_funcs not found"

# For all things rust
[ -f ~/dotfiles/bash/.bash_rust ] && source ~/dotfiles/bash/.bash_rust || echo -e "Warning: ~/dotfiles/bash/.bash_rust not found"

# For tiny python virtual environment business
[ -f ~/dotfiles/bash/.bash_python ] && source ~/dotfiles/bash/.bash_python || echo -e "Warning: ~/dotfiles/bash/.bash_python not found"

# Profiling bash startup (comment)
# If you startup a new Bash session manually (i.e. bash -xl), you can see what is run on login.
#PS4='+ $(date "+%s.%N")\011 '
#set +x
#exec 2>&3 3>&-
