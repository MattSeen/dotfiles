export PATH=$PATH:$HOME/dotfiles_scripts:
export PATH=$PATH:$HOME/dotfiles_git_scripts:
export PATH=$PATH:$HOME/dotfiles_svn_scripts:
export GIT_TEMPLATE_DIR=$HOME/dotfiles_git_template/
export GIT_EXTERNAL_DIFF=~/dotfiles_tools/winmerge.sh

export SVN_EDITOR=nano

eval "$(grunt --completion=bash)"

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

