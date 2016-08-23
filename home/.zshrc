# User configuration
export PATH="/usr/local/bin:	/usr/local/share/python:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Colorize terminal
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Set vim mode
bindkey -v

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Custom stuff
source ~/.aliases

# Vim autosave
# source ~/.vim/bundle/tmux-config/tmux-autowrite/autowrite-vim.sh
#
bindkey '^R' history-incremental-search-backward
# source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

export PATH="/usr/local/sbin:$PATH"
source /Users/julia/antigen.zsh
# source /Users/julia/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle fasd
antigen bundle tmux
antigen bundle osx
antigen bundle history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
antigen apply

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(rbenv init -)"
