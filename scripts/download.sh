#/usr/bin/env sh

set -e

# Check that we have some essential programs already installed.
hash zsh >/dev/null 2>&1 || { echo >&2 "Need zsh.  Aborting."; exit 1; }
hash git >/dev/null 2>&1 || { echo >&2 "Need git.  Aborting."; exit 1; }

# Check that the 'dotfiles' aren't already installed
if [ ! -n "$DOTFILES" ]; then
  DOTFILES=~/.oh-my-dotfiles
fi

if [ -d "$DOTFILES" ]; then
  echo "\033[0;33mYou already have Oh My Dotfiles installed.\033[0m
You'll need to remove $DOTFILES if you want to install.
\033[0;34mTry this: $\033[0m sh .oh-my-dotfiles/scripts/omd-remove.sh"
  exit
fi

echo "\033[0;34mCloning Oh My Dotfiles...\033[0m"
/usr/bin/env git clone https://github.com/ukrutt/oh-my-dotfiles-test.git $DOTFILES

echo "\033[032m"'Oh My Dotfiles have now been downloaded'"\033[0m"

echo "\033[0;34mTo remove: $\033[0m sh .oh-my-dotfiles/scripts/omd-remove.sh"
