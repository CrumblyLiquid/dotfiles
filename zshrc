# Enable Starship prompt
eval "$(starship init zsh)"

# Enable 256-color mode
export TERM="xterm-256color"

# Configure oh-my-zsh
ZSH="/usr/share/oh-my-zsh/"
zstyle ':omz:update' mode disabled

# Cache
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
    mkdir $ZSH_CACHE_DIR
fi

# Plugins
plugins=(git ripgrep rust python)

# Plugins from Arch Linux repositories
# TODO: Migrate oh-my-zsh plugins to some plugin manager
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Run oh-my-zsh
source $ZSH/oh-my-zsh.sh

# neovim-symlinks AUR package can be used insted
# alias vim="nvim"

# Go up certain amount of directories
up () {
  if [ -z $1 ]; then
    cd ..
  elif [ $1 -gt 0 ]; then
    let count=1
    cdstr=".."
    while [ $count -lt $1 ]; do
      cdstr="$cdstr/.."
      let count=count+1
    done
    cd $cdstr
  else
    echo "Argument must be a positive integer."
  fi
}

# Git
# Not needed for now because of oh-my-zsh
#for al in `git --list-cmds=alias`; do
#    alias g$al="git $al"
#done

# Open file with the default program
alias open="xdg-open"

# Go to .dotfiles directory
alias dotfiles="cd ~/.dotfiles"
alias dots=dotfiles

# List files
alias ls="eza --icons"
alias ll="ls -alh"

alias gpp="g++"
alias nv="nvim"
