#!/usr/bin/env bash
#
# bootstrap installs things.

# Robust way of getting the path to the ancestor of the directory of this file.
DOTFILES_ROOT="$( cd "$( dirname "$0" )/.." && pwd)"

BACKUP=".backup-$(date +%Y%m%d-%H%M%S)"

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

setup_gitconfig () {
  if ! [ -f ${DOTFILES_ROOT}/gitconfig.symlink ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" ${DOTFILES_ROOT}/gitconfig.symlink.example > ${DOTFILES_ROOT}/gitconfig.symlink

    success 'gitconfig'
  fi
}

link_files () {
  ln -s $1 $2
  success "linked $1 to $2"
}

install_dotfiles () {
  info 'installing dotfiles'

  overwrite_all=false
  backup_all=false
  skip_all=false

  for source in `find $DOTFILES_ROOT -maxdepth 1 -name \*.symlink`
  do
    # NOTE: The '%.*' part below strips the extension
    dest="$HOME/.`basename \"${source%.*}\"`"

    if [ -f $dest ] || [ -d $dest ] || [ -L ${dest} ]
    then

      overwrite=false
      backup=false
      skip=false

      case $(readlink ${dest}) in
          *${DOTFILES_ROOT}* ) skip=true ;;
      esac

      if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ] && [ "${skip}" == "false" ]
      then
        user "File already exists: ${dest}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi

      if [ "$overwrite" == "true" ] || [ "$overwrite_all" == "true" ]
      then
        rm -rf $dest
        success "removed $dest"
      fi

      if [ "$backup" == "true" ] || [ "$backup_all" == "true" ]
      then
        mv ${dest} ${dest}${BACKUP}
        success "moved ${dest} to ${dest}${BACKUP}"
      fi

      if [ "$skip" == "false" ] && [ "$skip_all" == "false" ]
      then
        link_files $source $dest
      else
        success "skipped $source"
      fi

    else
      link_files $source $dest
    fi

  done
}

echo "DOTFILES_ROOT is '${DOTFILES_ROOT}'"
echo "dirname is $(dirname $0)"

setup_gitconfig
install_dotfiles

# # If we're on a Mac, let's install and setup homebrew.
# if [ "$(uname -s)" == "Darwin" ]
# then
#   info "installing dependencies"
#   if source bin/dot > /tmp/dotfiles-dot 2>&1
#   then
#     success "dependencies installed"
#   else
#     fail "error installing dependencies"
#   fi
# fi

echo ''
echo '  All installed!'
