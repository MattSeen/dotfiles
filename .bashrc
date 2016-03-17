echo "==================================="
echo "Hi $USERNAME."
echo "It's $(date +"%H:%M:%S on the %d-%m-%Y")"
echo "About to (re)load your dotfile set."
echo "==================================="
echo ""

export DOTFILE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $DOTFILE_DIR/bin/utils/functions.sh

export TEXT_EDITOR_PATH="";
export EDITOR_CMD="";

export BROWSER_PATH="";
export BROWSER_CMD="";

. $DOTFILE_DIR/bin/utils/dotfileFeatures.sh

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
