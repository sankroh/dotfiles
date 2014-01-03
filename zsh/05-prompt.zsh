function virtualenv_info {
    # Python virtualenv
    _venv=`basename "$VIRTUAL_ENV"`
    venv="" # need this to clear it when we leave a venv
    if [[ -n $_venv ]]; then
        venv=$_venv
    fi

    if [[ -n "$venv" ]]; then
        echo "$venv"
    else
        echo - -
    fi
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

function shortpath() {
    # Special vim-tab-like shortpath (~/folder/directory/foo => ~/f/d/foo)
    _pwd=`pwd | sed "s#$HOME#~#"`
    if [[ $_pwd == "~" ]]; then
        _dirname=$_pwd
    else
        _dirname=`dirname "$_pwd" | sed -E "s/\/(.)[^\/]*/\/\1/g"`
        if [[ $_dirname == "/" ]]; then
            _dirname=""
        fi
        _dirname="$_dirname/`basename "$_pwd"`"
    fi
    echo "${_dirname}"
}

# http://blog.joshdick.net/2012/12/30/my_git_prompt_for_zsh.html
# copied from https://gist.github.com/4415470
# Adapted from code found at <https://gist.github.com/1712320>.

#setopt promptsubst
autoload -U colors && colors # Enable colors in prompt


# If inside a Git repository, print its branch and state
function git_prompt_string() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "%{$fg[blue]%}${git_where#(refs/heads/|tags/)}%{$reset_color%}$(parse_git_state)"
}

function git_status() {
    _branch=$(git symbolic-ref HEAD 2>/dev/null)
    current_git_branch=${_branch#refs/heads/}
}

function dirty() {
    # Print nothing if not in a git repo
    [[ -z $current_git_branch ]] && return

    # Git branch / dirtiness
    # Dirtiness cribbed from:
    # http://henrik.nyh.se/2008/12/git-dirty-prompt#comment-8325834
    _dirty="*"
    if git update-index -q --refresh &>/dev/null; git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null && git diff-files --quiet --ignore-submodules 2>/dev/null
        then _dirty=""
    fi
    echo $_dirty
}

function untracked() {
    [[ -z $current_git_branch ]] && return
    _untracked=""
    # Taken from oh-my-zsh/lib/git.zsh
    if git status --porcelain 2>/dev/null | grep '^??' &>/dev/null
        then _untracked="*"
    fi
    echo $_untracked
}

function branch() {
    if [[ -n "$current_git_branch" ]]; then
        echo "$current_git_branch"
    else
        echo - -
    fi
}

function _git_prompt_string(){
  git_status
  echo "${PR_MAGENTA}$(branch)${PR_RED}$(dirty)%f${PR_YELLOW}$(untracked)%f"
}

# determine Ruby version whether using RVM or rbenv
# the chpwd_functions line cause this to update only when the directory changes
function _update_ruby_version() {
    typeset -g ruby_version=''
    if which rvm-prompt &> /dev/null; then
      # ruby_version="$(rvm-prompt i v g)"
      ruby_version="$(rvm-prompt i v p g)"
    else
      if which rbenv &> /dev/null; then
        ruby_version="$(rbenv version | sed -e "s/ (set.*$//")"
      fi
    fi
}

# list of functions to call for each directory change
chpwd_functions+=(_update_ruby_version)

function current_pwd {
  echo $(pwd | sed -e "s,^$HOME,~,")
}

function precmd() {
  _time="[${PR_GREEN}%T%f]"
  _hostname="${PR_GREEN}%m%f"
  _path="${PR_BLUE}$(shortpath)%f"
  _end="${PR_BLUE}»%f"

  export PS1="${_time} ${_hostname}:${_path} {${PR_MAGENTA}$(virtualenv_info)%f} [$(_git_prompt_string)]
${_end} "

  export RPS1="%(?..${PR_RED}%?%f)"
}
