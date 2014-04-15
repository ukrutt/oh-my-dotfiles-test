# Try to run this as
#
#  $ sh test.sh
#
# and
#
#  $ sh test.sh foo



echo $0

echo "Number of arguments is $#"

OOB="oob"

# if [ $1 = "*${OOB}*" ]; then
#     echo "There is a match - found '${OOB}' in '$1'"
# else
#     echo "No match"
# fi

case $1 in
  *${OOB}*) echo "Found it in the variable OOB" ;;
  *oob*) echo "Found it with hardcoded 'oob'" ;;
  *) echo "Not a substring" ;;
esac

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

user "Remove symlinks to ${DOTFILES}? [Y/n]"
read action
case ${action} in
    ""|[Yy]* )
        echo ""
        echo "OK, removing symlinks"
        ;;
    * )
        echo ""
        echo "OK, not removing symlinks"
        ;;
esac


# if [ -n "$1" ]; then
#     echo "1 Length of '$1' is nonzero (${#1})"
# else
#     echo "1 Length of '$1' is zero (${#1})"
# fi

# if [ -z "$1" ]; then
#     echo "2 Length of '$1' is zero (${#1})"
# else
#     echo "2 Length of '$1' is nonzero (${#1})"
# fi

# empty=''

# if [ -n "${empty}" ]; then
#     echo "3 Length of '$empty' is nonzero (${#empty})"
# fi

# if [ -z "${empty}" ]; then
#     echo "4 Length of '$empty' is zero (${#empty})"
# fi

# echo "Program is $0"
