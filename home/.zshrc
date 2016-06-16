 # Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZDOTDIR=$HOME

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx tmux gitfast fasd history-substring-search nyan zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

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
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
# vvv PLACE THESE CONTENTS IN YOUR .bash_profile vvv

# Enable makersinit

# Main function

function makersinit {
  git init
  cat > .git/hooks/pre-push.sample <<'endfn'
  #!/bin/sh
  echo 'Pushing details to Tracker'
  # Notifies a webhook on attempted "git push".  Called by "git
  # push" after it has checked the remote status, but before anything has been
  # pushed.  If this script exits with a non-zero status nothing will be pushed.
  #
  # This hook is called with the following parameters:
  #
  # $1 -- Name of the remote to which the push is being done
  # $2 -- URL to which the push is being done
  #
  # If pushing without using a named remote those arguments will be equal.
  #
  # Information about the commits which are being pushed is supplied as lines to
  # the standard input in the form:
  #
  #   <local ref> <local sha1> <remote ref> <remote sha1>
  #

  # Utility functions
  # Webhook-posting function

  function posthook {
    curl "git-receiver.herokuapp.com/commits" \
    -X POST \
    -H "Content-type: application/json" \
    -d "{\"email\": \""$1"\", \"commits\": ["$2"], \"remote_url\": \""$3"\"}"
  }

  # Join function in the style of Pascal Pilz

  function join { local IFS="$1"; shift; echo "$*"; }
  
  remote="$1"
  url="$2"

  z40=0000000000000000000000000000000000000000

  IFS=' '
  while read local_ref local_sha remote_ref remote_sha
  do
    if [ "$local_sha" = $z40 ]
    then
      # Handle delete
      echo 'Local SHA is $z40'
                  :
    else
      if [ "$remote_sha" = $z40 ]
      then
        # New branch, examine all commits
        range="$local_sha"
      else
        # Update to existing branch, examine new commits
        range="$remote_sha..$local_sha"
      fi
  
      # Get all commits in the relevant range
      commits=`git rev-list "$range"`
      commits_array=()
      if [ -n "$commits" ]
      then
        # Construct an array of the commit SHAs
        while read -r line; do
          commits_array+=(\""$line"\")
        done <<< "$commits"
        # Construct the joined string for JSON
        commits_string=`join , "${commits_array[@]}"`
        email=`git config user.email`
        # Post the commits to the webhook along with the user
        posthook "$email" "$commits_string" "$url"
        exit 0
      else
        echo "Commit is empty"
      fi
    fi
  done

  exit 0
endfn

  mv .git/hooks/pre-push.sample .git/hooks/pre-push
  echo 'Initialized Makers push script'
}


# ^^^ END makersinit SCRIPT ^^^
export PATH="/usr/local/sbin:$PATH"
