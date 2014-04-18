#/usr/bin/env sh

set -e

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

echo "Want better dotfiles?"
echo "Don't worry, I got your back."
echo " "
echo "      O     |  O     "
echo "     / \    |\/|\    "
echo "    /   \      | \   "
echo "     / \      / \    "
echo "    /   \    /   \   "


# Check that we have some essential programs already installed.
hash zsh >/dev/null 2>&1 || { echo >&2 "Need zsh.  Aborting."; exit 1; }
hash git >/dev/null 2>&1 || { echo >&2 "Need git.  Aborting."; exit 1; }

if [ -z "$1" ]; then
    GIT_ORIGIN=https://github.com/ukrutt/oh-my-dotfiles-test.git
else
    echo "Using '$1' as origin"
    # Hardcoded
    ##GIT_ORIGIN=${HOME}/work/projects/oh-my-dotfiles-test
    GIT_ORIGIN=$1
fi

# Check that the 'dotfiles' aren't already installed
if [ ! -n "${DOTFILES}" ]; then
  DOTFILES=~/.oh-my-dotfiles
fi

if [ -d "${DOTFILES}" ]; then
  echo "\033[0;33mYou already have Oh My Dotfiles installed.\033[0m
You'll need to remove ${DOTFILES} if you want to install.
\033[0;34mTry this: $\033[0m sh ${DOTFILES}/scripts/omd-remove.sh"
  exit
fi

echo "\033[0;34mCloning Oh My Dotfiles...\033[0m"
echo "git clone ${GIT_ORIGIN} ${DOTFILES}"
TMP_OMD=$(mktemp -d 'omd_XXXXXX')
/usr/bin/env git clone ${GIT_ORIGIN} ${TMP_OMD}
mv ${TMP_OMD} ${DOTFILES}
echo "\033[0;34mDownloading Oh My Zsh...\033[0m"
cd ${DOTFILES}
/usr/bin/env git submodule init
/usr/bin/env git submodule update

echo "\033[032m"'Oh My Dotfiles have now been downloaded'"\033[0m"

echo "\033[0;34mTo remove:  $\033[0m sh ${DOTFILES}/scripts/omd-remove.sh"

# user "Download Oh-My_Zsh? [Y/n]"
# read -n 1 action
# if [[ ! -n ${action} || ${action} == "Y" || ${action} == "y" ]]; then
#     echo ""
#     echo "OK, downloading Oh My Zsh."
#     cd ${DOTFILES}
#     /usr/bin/env git submodule init
#     /usr/bin/env git submodule update
# else
#     echo ""
#     echo "OK, not downloading Oh My Zsh."
# fi

echo "\033[032mTo install: $\033[0m sh ${DOTFILES}/scripts/install.sh"
