# Directory information
if [[ $IS_MAC -eq 1 ]]; then
    alias lh='ls -d .*' # show hidden files/directories only
    alias lsd='ls -aFhlG'
    alias l='ls -al'
    alias ls='ls -GFh' # Colorize output, add file type indicator, and put sizes in human readable format
    alias ll='ls -GFhal' # Same as above, but in long listing format
fi
if [[ $IS_LINUX -eq 1 ]]; then
    alias lh='ls -d .* --color' # show hidden files/directories only
    alias lsd='ls -aFhlG --color'
    alias l='ls -al --color'
    alias ls='ls -GFh --color' # Colorize output, add file type indicator, and put sizes in human readable format
    alias ll='ls -GFhl --color' # Same as above, but in long listing format
fi

alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
alias dus='du -sckx * | sort -nr' #directories sorted by size

# Mac only things
if [[ $IS_MAC -eq 1 ]]; then
    alias oo='open .' # open current directory in OS X Finder
    # refresh brew by upgrading all outdated casks
    alias refreshbrew='brew outdated | while read cask; do brew upgrade $cask; done'
    alias bu='brew update; brew upgrade; brew cleanup; brew doctor'
fi

# Note these require zsh
alias ltd='ls *(m0)' # files & directories modified in last day
alias lt='ls *(.m0)' # files (no directories) modified in last day
alias lnew='ls *(.om[1,3])' # list three newest

# Sudo
alias svim='sudo vim'
alias stail="sudo tail"

# Package managers
alias pi='pip install'
alias pie='pip install -e'
alias pu='pip uninstall'

# Git
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias glg="git log --graph --pretty=format:'%Cblue%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gpl='git pull'
alias gps='git push'
alias gs='git status'
alias gt='git tag'
alias gr='git rel'
alias ga='git add'
alias gap='git add -p'
alias gco='git checkout'
alias gst='git stash'
alias gsa='git stash apply'
alias gm='git merge'
alias gf='git fetch'

# gsh shows the number of commits for the current repos for all developers
alias gsh="git shortlog | grep -E '^[ ]+\w+' | wc -l"

function gcamp() {
    gcam "$1" && gps
}

function mg() {
    find . \
        -mindepth 1 -maxdepth 2 \
        -type d -name .git \
    | while read git_dir; do
        dir=`dirname $git_dir`
        echo $dir:
        cd $dir
        git $*
        cd - >/dev/null
        echo ""
    done
}

# RubyGems
alias gems='gem search -b'
alias geml='gem list -l'
alias gemi='gem install -b'
alias gemu='gem uninstall'

# Misc
alias screen='TERM=screen screen'
alias rmpyc='rm **/*.pyc'
alias v=vagrant
alias be='bundle exec'
alias ack='ack -a'
alias history='fc -l 1' # Force display of entire zsh history

# Rsync
alias rsync-copy="rsync -av --progress -h"
alias rsync-move="rsync -av --progress -h --remove-source-files"
alias rsync-update="rsync -avu --progress -h"
alias rsync-synchronize="rsync -avu --delete --progress -h"

# Functions

function cycle() {
    v destroy $1 && v up $1
}

function ports() {
    FAMILY=TCP
    STATE="-sTCP:LISTEN"
    if [[ -n $1 ]]; then
        FAMILY=$1
        STATE=
    fi
    sudo lsof -i${FAMILY} -P $STATE | tr -s " " "\t" | cut -f 1,5,8- | tail -n +2 | sort | uniq
}

function json() {
    CMD="curl -s \"$1\" | python -m json.tool"
    if which pygmentize > /dev/null; then
        eval "$CMD | pygmentize -l javascript"
    else
        eval $CMD
        echo "You didn't have pygmentize installed, so no colors for you!"
    fi
}
