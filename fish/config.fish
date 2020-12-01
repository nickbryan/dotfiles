set PATH $HOME/.cargo/bin $PATH
set EDITOR nvim

# set the workspace path
set -x GOPATH ~/go

# add the go bin path to be able to execute our programs
set -x PATH $PATH ~/go/bin $GOPATH/bin
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

