export PATH=$PATH:$HOME/dotfiles_scripts:
export PATH=$PATH:$HOME/dotfiles_git_scripts:
export PATH=$PATH:$HOME/dotfiles_svn_scripts:
export GIT_TEMPLATE_DIR=$HOME/dotfiles_git_template/
export GIT_EXTERNAL_DIFF=~/dotfiles_tools/winmerge.sh

export SVN_EDITOR=nano

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

# # # # # # # # # # # # # # # #
# Git commands that didn't work in .gitconfig
# # # # # # # # # # # # # # # #

alias gitalias="cat ~/.gitconfig | sed -n '/\[alias\]/,/\[core\]/p' | grep -Ev '\[alias\]|\[core\]' | less"

# # # # # # # # # # # # # # # #
# Rake autocomplete task names
# Source: https://gist.github.com/MattSeen/7704275
# # # # # # # # # # # # # # # #
source ~/dotfiles_auto_complete/rake.sh

# # # # # # # # # # # # # # # #
# Bashmarks include
# Repo: https://github.com/twerth/bashmarks
# # # # # # # # # # # # # # # #
source ~/dotfiles_tools/bashmarks/bashmarks.sh

source ~/dotfiles_svn_scripts/.svnaliases

source ~/dotfiles_scripts/trelloWrappers


mkcd () {
    mkdir -p $1
    cd $1
}

alias cwp="convertWindowsPathToUnix"
# Source: http://stackoverflow.com/a/13701495/1367612

convertWindowsPathToUnix() {
    echo $(echo "/$1" | sed -e 's/\\/\//g' -e 's/://')
}

shuffle() {
    awk 'BEGIN{srand();} {printf "%06d %s\n", rand()*1000000, $0;}' | sort -n | cut -c8-
}

reloadProfile() {
	. ~/.bash_profile
}

if [ -f ~/.bashrclocal ]; then
	. ~/.bashrclocal
else
	touch ~/.bashrclocal
fi
