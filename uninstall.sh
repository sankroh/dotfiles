FILES="
    zshrc
    zshenv
    gitconfig
    gitexcludes
    pylintrc
    vimrc
"
# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset

echo "$(tput bold)Looking for an existing zsh config...${txtrst}"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
then
    echo "$(tput setaf 4)Found ~/.zshrc.${txtrst}";
    echo "${bldred} Removing ~/.zshrc${txtrst}"
    rm ~/.zshrc
fi

for file in $FILES
do
    TARGET="$HOME/.$file"

    # Create backup file if the target already exists and is not a symlink
    if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "${bldwht}*** INFO *** $TARGET already exists; removing file!{txtrst}"
        rm "$TARGET"
    else
        echo "${bldwht}*** WARNING *** $TARGET does not exists; doing nothing${txtrst}"
    fi
done

echo "$(tput setaf 4)Time to change your default shell back to bash!${txtrst}"
chsh -s `which bash`
echo "\n\n ${bldblu}Dotfiles are now uninstalled.${txtrst}"
/usr/bin/env bash
exit 0
