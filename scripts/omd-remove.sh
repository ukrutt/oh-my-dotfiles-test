# Tool to remove/backup dotfiles folder

if [ ! -n "$DOTFILES" ]; then
    DOTFILES="$( cd "$( dirname "$0" )/.." && pwd)"
fi

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

user "Remove symlinks to ${DOTFILES}? [Y/n]"
read action
case ${action} in
    ""|[Yy]* )
        echo ""
        echo "OK, removing symlinks"
        sh ${DOTFILES}/scripts/omd-remove-symlinks.sh
        ;;
    * )
        echo ""
        echo "OK, not removing symlinks"
        ;;
esac


# echo "Removing ${DOTFILES}"
if [ -d ${DOTFILES} ]; then
    user "Found ${DOTFILES} - remove? [y/N]"
    read action
    case ${action} in
        [Yy]* )
            DOTFILES_SAVE=".omd-uninstalled-`date +%Y%m%d-%H%M%S`";
            echo ""
            echo "Found ${DOTFILES} - renaming to ~/${DOTFILES_SAVE}"
            mv ${DOTFILES} ~/${DOTFILES_SAVE}
            ;;
        * )
            echo ""
            echo "OK, not removing"
            ;;
    esac
else
    echo "No '${DOTFILES}' folder"
fi

# echo "Looking for original zsh config..."
# if [ -f ~/.zshrc.pre-oh-my-dotfiles ] || [ -h ~/.zshrc.pre-oh-my-dotfiles ]
# then
#   echo "Found ~/.zshrc.pre-oh-my-dotfiles -- Restoring to ~/.zshrc";

#   if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
#   then
#     ZSHRC_SAVE=".zshrc.omz-uninstalled-`date +%Y%m%d%H%M%S`";
#     echo "Found ~/.zshrc -- Renaming to ~/${ZSHRC_SAVE}";
#     mv ~/.zshrc ~/${ZSHRC_SAVE};
#   fi

#   mv ~/.zshrc.pre-oh-my-dotfiles ~/.zshrc;

#   source ~/.zshrc;
# else
#   echo "Switching back to bash"
#   chsh -s /bin/bash
#   source /etc/profile
# fi

# echo "Thanks for trying out Oh My Zsh. It's been uninstalled."
