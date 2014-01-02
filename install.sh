FILES="
    zshrc
    zshenv
    gitconfig
    gitexcludes
    pylintrc
    vimrc
"
if [ -d ~/.dotfiles ]
then
  echo "\033[0;33mYou already have One Oh My Zsh Directory.\033[0m You'll need to remove  ~/.dotfiles if you want to clone"
  exit
fi
echo "\033[0;34mLooking for an existing zsh config...\033[0m"
if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
then
  echo "\033[0;33mFound ~/.zshrc.\033[0m \033[0;32mBacking up to ~/.zshrc.pre-oh-my-zsh\033[0m";
  mv ~/.zshrc ~/.zshrc.pre-zsh;
fi
echo "\033[0;34mUsing the Zsh template file and adding it to ~/.zshrc\033[0m"

for file in $FILES
do
    SOURCE="$HOME/.dotfiles/$file"
    TARGET="$HOME/.$file"

    # Create backup file if the target already exists and is not a symlink
    if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
        echo "*** WARNING *** $TARGET already exists; copying original to .$file.old"
        mv "$TARGET" "$TARGET.old"
    fi

    cp "$SOURCE" "$TARGET"
done

echo "\033[0;34mTime to change your default shell to zsh!\033[0m"
chsh -s `which zsh`
echo "\n\n \033[0;32m Dotfiles are now installed.\033[0m"
echo "\n\n \033[0;32mPlease look over the ~/.zshrc file.\033[0m"
/usr/bin/env zsh
source ~/.zshrc
exit 0
