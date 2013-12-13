# Was thinking about command line aliases in general today. 
# Stumbled on this article.
# 
# http://danlimerick.wordpress.com/2011/06/10/git-for-windows-tip-setting-shell-aliases-with-msysgit/

alias catn='cat --number'
alias ls='ls -F --color'
alias sublime='/c/Program\ Files/Sublime\ Text\ 2/sublime_text.exe --new-window'
alias cls='clear'

# alias runguard='bundle exec guard'


# # # # # # # # # # # # # # # #
# Rake autocomplete task names
# # # # # # # # # # # # # # # #
source ~/rake.sh

# # # # # # # # # # # # # # # # # 
# This is when using git bash and 
# ansicon together for better
# colorizing of output
# # # # # # # # # # # # # # # # #

alias ccat='pygmentize -O style=monokai -f terminal -g'
source ~/git-prompt.sh

export PS1='\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[31m\]$(__git_ps1 " (%s)")\n\[\033[01;34m\]$\[\033[00m\] '
