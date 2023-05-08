set PATH $HOME/.cargo/bin $PATH
set EDITOR nvim

# set the workspace path
set -x GOPATH ~/go
set -x GOPRIVATE gitlab.com/nickbryan/recipist
set -x EARTHLY_SECRETS GITLAB_NETRC=machine gitlab.com login oauth2 password glpat-Hvmhv4y4yM2E3ScRzXmS

# add the go bin path to be able to execute our programs
set -x PATH $PATH ~/go/bin $GOPATH/bin
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/sbin" $fish_user_paths

