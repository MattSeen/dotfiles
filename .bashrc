# Was thinking about command line aliases in general today.
# Stumbled on this article.
#
# http://danlimerick.wordpress.com/2011/06/10/git-for-windows-tip-setting-shell-aliases-with-msysgit/

alias catn='cat --number'
alias ls='ls -F --color'
alias sublime='/c/Program\ Files/Sublime\ Text\ 2/sublime_text.exe --new-window'
alias cls='clear'
alias dir='ls'

# Source: http://justinlilly.com/dotfiles/zsh.html
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias runguard='bundle exec guard'


# # # # # # # # # # # # # # # #
# Git commands that didn't work in .gitconfig
# # # # # # # # # # # # # # # #

alias gitalias="cat ~/.gitconfig | sed -n '/\[alias\]/,/\[core\]/p' | grep -Ev '\[alias\]|\[core\]' | less"

# # # # # # # # # # # # # # # #
# Rake autocomplete task names
# Source: https://gist.github.com/MattSeen/7704275
# # # # # # # # # # # # # # # #
source ~/rake.sh

# # # # # # # # # # # # # # # #
# Bashmarks include
# Repo: https://github.com/twerth/bashmarks
# # # # # # # # # # # # # # # #
source ~/bashmarks/bashmarks.sh

# # # # # # # # # # # # # # # #
# Arcanist autocomplete
# # # # # # # # # # # # # # # #
source /c/DEVUtils/arcanist/arcanist/resources/shell/bash-completion

# # # # # # # # # # # # # # # # #
# This is when using git bash and
# ansicon together for better
# colorizing of output
# # # # # # # # # # # # # # # # #
alias ccat='pygmentize -O style=monokai -f terminal -g'
source ~/git-prompt.sh

export PS1='\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[31m\]$(__git_ps1 " (%s)")\[\033[01;34m\]$\[\033[00m\] '

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
