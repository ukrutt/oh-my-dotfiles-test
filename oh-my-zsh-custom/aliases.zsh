## -*- mode: shell-script; -*-

alias \?="history-grep"
history-grep () {
    if [[ $# -eq 0 ]]; then
        fc -lf 1;
    else
        fc -lf 1 | grep -i $1
    fi
}

alias locatei="locate \* | grep -i"

alias mv="mv -i"
alias cp="cp -i"

if [[ "$(uname -s)" == "Darwin" ]]; then
    alias ls='ls -F'
    alias ll='ls -lrt'
else
    # I am at a regular UNIX or cygwin account
    alias ls='ls --color=auto -F'
    alias ll='ls --color=auto -ort'
    alias mainwin='precmd() { print -Pn "\e]0; *** main *** \a" }'
fi

[[ -r ${HOME}/.dotfiles/.sh-aliases ]] && \
    alias sa='. ${HOME}/.dotfiles/.sh-aliases'
if [[ $ZSH_NAME == zsh ]]; then
    alias sz='source $HOME/.zshrc'
else
    alias sc='source $HOME/.bashrc'
fi

alias diffb='diff --brief'
alias diffbr='diff --brief --strip-trailing-cr -r'
alias diffbri="diffbr  -I '\\$\(Revision\|Date\|Author\): .* \\$'"
alias topu='top -us 5'
alias cdw='cd "$(pwd -P)"'
alias diskplass='du -ks * .??* . | sort -n | tail -16'

alias epstopdfall="find . -maxdepth 1 -name '*.eps' -exec epstopdf \{\} \;"

idiskbackupdir="/Volumes/iDisk/Documents/Backup/$HOST"
etcfiles="/etc/(pr|log|cs|z)*"
alias savedotfiles="rsync -vptl $etcfiles $HOME/.??* $idiskbackupdir/Dotfiles | grep -v 'skipping directory'; rsync -av $HOME/bin $idiskbackupdir"

alias tmatlab="matlab -nodesktop -nosplash"
alias topen="open -a Terminal.app ."

if [[ "$(uname -s)" == "Darwin" ]]; then
	alias TextEdit="open -a /Applications/TextEdit.app"
	alias te=TextEdit
	alias TeXShop="open -a /Applications/TeX/TeXShop.app"
	alias ts=TeXShop

        # cdf: pushd to the position of the currently open Finder window
else
	emacsClient="emacsclient"
fi

# alias buddy-setip='ssh junior@localhost bin/buddy-setip'
alias buddy-setip='~junior/bin/buddy-setip'

setloc () {
    if [[ $# -eq 0 ]]; then
	LOCATION='Automatic';
    else
	LOCATION=$1;
    fi
    scselect $LOCATION
    buddy-setip
}

alias setloc-home-a='setloc "Home AirPort"'
alias setloc-ece-6-117='setloc "ECE 6-117"'
alias setloc-ubean='setloc "UBean AirPort"'

alias pingschool="ping -c 5 128.101.101.101"

# alias findnosvn='-path "*/.svn" -prune -o'

# findnosvn () {
#     directory=$1
#     rest=$2
#     find $directory -path '*/.svn' -prune -o $2
# }

ff () {
    findname=$1
    directory=${2:-.}
    find $directory -path '*/.svn' -prune -o -iname "*$findname*" | gvs
}

mfh () {
    findname=$1
    directory=${2:-.}
    mdfind -onlyin ${directory} ${findname}
}

# gc () {
#     grepsymbol=$@
#     command="find . \( -name '*.c' -o -name '*.h' -o -name '*.m' \) -exec grep -nH ${grepsymbol} {} \;"
#     echo ${command}
#     eval ${command}
# }

gvw () {
    grep -v '^$'
}

alias gvst="gvw | grep -v '^Performing status on external item at'"

gvs () {
    grep -v '\.svn'
}

gvss () {
    grep -v 'vssver\.scc' | grep -v 'mssccprj\.scc'
}

# gvd () {
#     egrep -v '\/(RAM_)?(FLASH_)?Debug(_LoPwr)?\/'
# }

gvd () {
    grep -v '\.DS_Store'
}

gvt () {
    egrep -v '\.(c|h)~:'
}

grs () {
    grep -nr --exclude='*.svn-base' $@ . | gvs
}

grd () {
    grs $@ | gvd | gvt
}

ffs () {
    ff $1 ${2:-.} | gvs
}

svndiffw () {
    svn diff --diff-cmd diff -x -uwB $@
}

svnrevertr () {
    svn cat -r $1 $2 >! $2
}

svndos2unix () {
    svn st | awk '/^M +/ {print $2}' | xargs dos2unix
}

svnunix2dos () {
    svn st | awk '/^M +/ {print $2}' | xargs unix2dos
}

svnchmodPlusW () {
    svn st | awk '/^M +/ {print $2}' | xargs chmod +w
}

markdown_pdf () {
    fn=$(echo $1 | cut -f1 -d.).pdf
    echo ${fn}
    markdown $1 | htmldoc --continuous -f ${fn}
}

markdown_html () {
    fn=$(echo $1 | cut -f1 -d.).html
    echo ${fn}
    markdown $1 >! ${fn}
}

alias svnSetKW="svn propset svn:keywords \"Date Revision Author HeadURL Id\""
alias svnSetCHMKW="find . -name '*.c' | xargs svn propset svn:keywords \"Date Revision Author HeadURL Id\""

alias acroread="open -a '/Applications/Adobe Reader 8/Adobe Reader.app'"
alias adoberead=acroread

renice_and_list () {
    sudo renice 10 $1
    ps -alxww | grep $1 | grep -v grep
}


if [[ "$(uname -o 2>/dev/null)" == "Cygwin" ]]; then
    # This will give me something similar to 'open' on mac in windows.
    alias open="cmd /c start"
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
    alias sleepSystem="osascript -e 'tell application \"System Events\" to sleep'"
    alias screenSaver="/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"
fi

################################################################
## Python

# alias pimp="python `python -c \"import pimp; print pimp.__file__\"` -u http://www.python.org/packman/version-0.3/darwin-7.5.0-Power_Macintosh.plist"

# pimp() {
#     python `python -c "import pimp; print pimp.__file__"` $@
# }

# darwinportsIPython='/opt/local/bin/ipython'
# IPythonVars="LESS='iMr' EDITOR=${emacsClient}"
# if [[ $ZSH_NAME == zsh ]]; then
#     if [[ -x ${darwinportsIPython} ]]; then
#         alias ipython="${IPythonVars} ${darwinportsIPython}"
#         # alias ipythonw="${IPythonVars} ${darwinportsIPython}w"
#     else
#         alias ipython="${IPythonVars} $(whence -p ipython)"
#         # alias ipythonw="${IPythonVars} $(whence -p ipython)"
#     fi
# fi
# #alias ipython="${IPythonVars} ${IPython}"
# #alias ipythonw="LESS='iMr' pythonw $(whence -p ipython)"
# alias pylab="ipython -pylab"
# alias pylab-doe="pylab -profile doe"
# alias pylab-location="pylab -profile location"

################################################################
## C++

cppcompile(){
    file=${1%.(cc|cpp)}
    g++ -Wall $1 -o $file 
}

# alias gdbemacs='gdb --command=~/gdb_run_emacs_commands emacs'
# alias emacsnw="/usr/local/bin/emacs -nw \!*"
# alias emacsaq="open -a '/Applications/Emacs.app'"
# alias em="/usr/local/bin/emacs -nw -l ~/.emacs-text \!*"
# alias gnus="/usr/local/bin/emacs -nw -f gnus-unplugged"
# alias gnusplugged="/usr/local/bin/emacs -nw -f gnus"
