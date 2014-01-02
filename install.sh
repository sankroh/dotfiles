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
  echo "$(tput setaf 4)Found ~/.zshrc. ${bldblu}Backing up to ~/.zshrc.old${txtrst}";
  mv ~/.zshrc ~/.zshrc.old;
fi
echo "${bldwht}Generating a new .zshrc file and adding it to ~/.zshrc${txtrst}"

for file in $FILES
do
    SOURCE="$HOME/.dotfiles/$file"
    TARGET="$HOME/.$file"

    # Create backup file if the target already exists and is not a symlink
    if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "${bldred}*** WARNING *** $TARGET already exists; copying original to .$file.old${txtrst}"
        mv "$TARGET" "$TARGET.old"
    fi

    cp "$SOURCE" "$TARGET"
done

echo "$(tput setaf 4)Time to change your default shell to zsh!${txtrst}"
chsh -s `which zsh`
echo "$(tput setaf 4)Dotfiles are now installed.${txtrst}"
echo "${txtund}$(tput setaf 4)Please look over the ~/.zshrc file.${txtrst}"
/usr/bin/env zsh
source ~/.zshrc
exit 0
