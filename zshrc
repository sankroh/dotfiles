# Zsh dotdir folder
export ZSH=~/.dotfiles

# Source my dotfiles (in explicit order)
typeset -a DOTFILES
DOTFILES=(
    01-checks.zsh
    02-setopts.zsh
    03-colors.zsh
    04-exports.zsh
    05-prompt.zsh
    06-completion.zsh
    07-aliases.zsh
    08-functions.zsh
    09-history.zsh
    10-python.zsh
    11-workon.zsh
    12-django.zsh
)

for file in $DOTFILES; do
    file=$ZSH/zsh/$file
    [[ -f $file ]] && source $file
done

