echo "==================================="
echo "Hi $USERNAME."
echo "It's $(date +"%H:%M:%S on the %d-%m-%Y")"
echo "About to (re)load your dotfile set."
echo "==================================="
echo ""

export DOTFILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DOTFILE_DIR/bin/utils/functions.sh

# Features
USING_GIT=false
USING_SVN=false
USING_LIBS=true
USING_AUTOCOMPLETE=true

if $USING_LIBS; then
	source $DOTFILE_DIR/bin/libs/.using
fi

if $USING_GIT; then
	source $DOTFILE_DIR/bin/git_scripts/.using
fi

if $USING_SVN; then
	source $DOTFILE_DIR/bin/svn_scripts/.using
fi

if $USING_AUTOCOMPLETE; then
	source $DOTFILE_DIR/bin/auto_complete/.using
fi

# Was thinking about command line aliases in general today.
# Stumbled on this article.
#
# http://danlimerick.wordpress.com/2011/06/10/git-for-windows-tip-setting-shell-aliases-with-msysgit/

alias catn='cat --number'
alias lsf='ls -F --color'

# Source: http://justinlilly.com/dotfiles/zsh.html
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

mkcd () {
    mkdir -p $1
    cd $1
}

alias cwp="convertWindowsPathToUnix"
# Source: http://stackoverflow.com/a/13701495/1367612

convertWindowsPathToUnix() {
    echo $(echo "/$1" | sed -e 's/\\/\//g' -e 's/://')
}

# Useful command to help reloading scripts easier.
reloadProfile() {
	. ~/.bash_profile
}

loadLocalCopyOfScript $DOTFILE_DIR/.bashrc
