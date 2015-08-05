# Currently this path is appended to dynamically when picking a ruby version
# zshenv has already started PATH with rbenv so append only here
#export PATH=$PATH:/usr/local/bin:/usr/local/sbin:$HOME/bin
my_path=$HOME/.bin
local_path=/usr/local/bin:/usr/local/sbin
heroku_path=/usr/local/heroku/bin
coreutils_path=$(brew --prefix coreutils)/libexec/gnubin
export PATH=$coreutils_path:$heroku_path:$local_path:$PATH:$my_path

# remove duplicate entries
typeset -U PATH

# Setup terminal, and turn on colors
export DISPLAY=:0.0
export EDITOR=vim
export TERM=xterm-256color

# But still use emacs-style zsh bindings
bindkey -e

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

export LESS='--ignore-case --raw-control-chars'
export PAGER='less'

# Allow git to transcend FS boundaries
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1

# GOLANG path
export PATH=$PATH:/usr/local/opt/go/libexec/bin

