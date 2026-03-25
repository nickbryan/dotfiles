export ZSH="$HOME/.oh-my-zsh"

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc
fi

ZSH_THEME="gnzh" # set by `omz`

# Update omz automatically without asking.
zstyle ":omz:update" mode auto      
zstyle ":omz:update" frequency 1

# OMZ plugins, don't add too many as it slows down shell startup.
plugins=(aliases git history-substring-search macos safe-paste rust web-search)

export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
source $ZSH/oh-my-zsh.sh

export LANG=en_GB.UTF-8

export EDITOR="nvim"

# Personal aliases.
alias "cd."="cd ~/.dotfiles" 
alias ls="eza --icons=auto --git --git-repos"
alias ll="ls -lAh --color --group-directories-first"
alias cat="bat"
function nv() {
    if [ "$1" != "" ]
    then
        nvim $1
    else
        nvim .
    fi
}
alias tree="ls --tree"

function notes() {
    local month=$(date +%-m)
    local year=$(date +%Y)
    local quarter months first_year second_year

    if (( month >= 4 && month <= 6 )); then
        quarter=1; months="April, May, June"
        first_year=$year; second_year=$((year + 1))
    elif (( month >= 7 && month <= 9 )); then
        quarter=2; months="July, August, September"
        first_year=$year; second_year=$((year + 1))
    elif (( month >= 10 && month <= 12 )); then
        quarter=3; months="October, November, December"
        first_year=$year; second_year=$((year + 1))
    else
        quarter=4; months="January, February, March"
        first_year=$((year - 1)); second_year=$year
    fi

    if [[ -z "$NOTES_DIR" ]]; then
        echo "NOTES_DIR is not set"
        return 1
    fi

    local filename="${NOTES_DIR}/${first_year}_${second_year}_Q${quarter}.md"
    local template="$HOME/.dotfiles/templates/quarterly-notes.md"

    if [[ -f "$filename" ]]; then
        ${EDITOR:-nvim} "$filename"
        return
    fi

    if [[ ! -f "$template" ]]; then
        echo "Template not found: $template"
        return 1
    fi

    sed -e "s/{{QUARTER}}/Q${quarter}/g" \
        -e "s/{{MONTHS}}/${months}/g" \
        -e "s/{{FIRST_YEAR}}/${first_year}/g" \
        -e "s/{{SECOND_YEAR}}/${second_year}/g" \
        "$template" > "$filename"

    echo "Created $filename"
    ${EDITOR:-nvim} "$filename"
}

function notes-search() {
    if [[ -z "$NOTES_DIR" ]]; then
        echo "NOTES_DIR is not set"
        return 1
    fi

    rg --line-number --no-heading --color=always "" "$NOTES_DIR" \
        | fzf --ansi --delimiter=: \
              --preview 'bat --color=always --highlight-line {2} {1}' \
              --preview-window='up,60%,+{2}-10' \
              --query="${1:-}" \
              --bind 'enter:become(${EDITOR:-nvim} {1} +{2})'
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

# Python
export PATH="$(brew --prefix python)/libexec/bin:$PATH"

# Local exports etc.
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
eval "$(zellij setup --generate-auto-start zsh)"
