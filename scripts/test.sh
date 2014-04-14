# Try to run this as
#
#  $ sh test.sh
#
# and
#
#  $ sh test.sh foo



echo $0

echo "Number of arguments is $#"

if [ -n $1 ]; then
    echo "1 Length of '$1' is nonzero (${#1})"
else
    echo "1 Length of '$1' is zero (${#1})"
fi

if [ -z $1 ]; then
    echo "2 Length of '$1' is zero (${#1})"
else
    echo "2 Length of '$1' is nonzero (${#1})"
fi

empty='e'

if [ -n ${empty} ]; then
    echo "3 Length of '$empty' is nonzero (${#empty})"
fi

if [ -z ${empty} ]; then
    echo "4 Length of '$empty' is zero (${#empty})"
fi
