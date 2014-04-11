# Remove symlinks to here from ${HOME}

DOTFILES_ROOT="$( cd "$( dirname "$0" )/.." && pwd)"

# cd ${HOME}
info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

# fail () {
#   printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
#   echo ''
#   exit
# }

delete_link () {
    rm $1
    success "deleted $1"
}

skip_link () {
    success "skipped $1 -> $2"
}

delete_all=false
skip_all=false

for symlink in $(find ${HOME} -maxdepth 1 -type l); do
    target=$(readlink ${symlink})
    if [[ ${target} == *${DOTFILES_ROOT}* ]]; then
        delete=false
        skip=false
        if [ ${delete_all} == "false" ] && [ ${skip_all} == "false" ]; then
            user "Found symlink ${symlink} -> ${target}. [s]kip, [S]kip all, [d]elete, [D]elete all?"
            read -n 1 action
            case "$action" in
                d )
                    delete=true;;
                D )
                    delete_all=true;;
                s )
                    skip=true;;
                S )
                    skip_all=true;;
                * )
                    ;;
            esac
        fi
        if [ ${delete} == "true" ] || [ ${delete_all} == "true" ]; then
           delete_link ${symlink}
        fi
        if [ ${skip} == "true" ] || [ ${skip_all} == "true" ]; then
            skip_link ${symlink} ${target}
        fi
    else
        skip_link "${symlink}" "${target}"
    fi
done
