# bash completion for rake
#
# some code from on Jonathan Palardy's http://technotales.wordpress.com/2009/09/18/rake-completion-cache/
# and http://pastie.org/217324 found http://ragonrails.com/post/38905212/rake-bash-completion-ftw
#
# For details and discussion
# http://turadg.aleahmad.net/2011/02/bash-completion-for-rake-tasks/
#
# INSTALL
#
# Place in your bash completions.d and/or source in your .bash_profile
# If on a Mac with Homebrew, try "brew install bash-completion"
#
# USAGE
#
# Type 'rake' and hit tab twice to get completions.
# To clear the cache, run rake_cache_clear() in your shell.
#

function _rake_cache_path() {
  # If in a Rails app, put the cache in the cache dir
  # so version control ignores it
  if [ -e 'tmp/cache' ]; then
    prefix='tmp/cache/'
  fi
  echo "${prefix}.rake_t_cache"
}

function rake_cache_store() {
  rake --tasks --silent > "$(_rake_cache_path)"
}

function rake_cache_clear() {
  rm -f .rake_t_cache
  rm -f tmp/cache/.rake_t_cache
}

export COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

function _rakecomplete() {
  # error if no Rakefile
  if [ ! -e "rakefile.rb" ]; then
    echo "missing Rakefile"
    return 1
  fi

  # build cache if missing
  if [ ! -e "$(_rake_cache_path)" ]; then
    rake_cache_store
  fi

  local tasks=`awk '{print $2}' "$(_rake_cache_path)"`

  # Bash autocomplete would mess up when a colon was contained
  # in the task name. Interim solution I found on:
  # Source: http://willcode4beer.com/tips.jsp?set=tabMaven
  cur=${COMP_WORDS[COMP_CWORD]}
  colonprefixes=${cur%"${cur##*:}"}
  COMPREPLY=( $(compgen -W "${tasks}"  -- $cur))
  local i=${#COMPREPLY[*]}
  while [ $((--i)) -ge 0 ]; do
    COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
  done

  return 0
}

complete -o default -o nospace -F _rakecomplete rake
