export ZSH="$HOME/.oh-my-zsh"

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
fi

ZSH_THEME="gnzh"

# Update omz automatically without asking.
zstyle ":omz:update" mode auto      
zstyle ":omz:update" frequency 1

# OMZ plugins, don't add too many as it slows down shell startup.
plugins=(git history-substring-search)

export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
source $ZSH/oh-my-zsh.sh

export LANG=en_GB.UTF-8

export EDITOR="nvim"

# Personal aliases.
alias ll="gls -lAh --color --group-directories-first"
alias "cd."="cd ~/.dotfiles" 
function nv() {
    if [ "$1" != "" ]
    then
        nvim $1
    else
        nvim .
    fi
}

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Brew
export HOMEBREW_BUNDLE_FILE=~/.dotfiles/brew/Brewfile

# Go
export GOPATH=~/go
export PATH=$PATH:~/go/bin:$GOPATH/bin

# GPG
export GPG_TTY=$(tty) 
gpgconf --launch gpg-agent

# Local exports etc.
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
