autoload -U colors && colors # Enable colors in prompt

# The variables are wrapped in %{%}. This should be the case for every
# variable that does not contain space.
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
  eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
  export PR_$COLOR PR_BOLD_$COLOR
done

eval RESET='$reset_color'

# Clear LSCOLORS
unset LSCOLORS

# Main change, you can see directories on a dark background

if [[ $IS_MAC -eq 1 ]]; then
    export CLICOLOR=1
    export LSCOLORS=exfxcxdxbxegedabagacad
fi

if [[ $IS_LINUX -eq 1 ]]; then
    #LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
    #export LS_COLORS
    eval $(dircolors -b /etc/DIR_COLORS.256color)
fi
