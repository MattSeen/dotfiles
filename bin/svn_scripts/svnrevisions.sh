#!/bin/sh
# Usage:  svnrevisions $file
# Output: list of fully numeric svn revisions (without the r), one per line

file="$@"
    svn log "$file" 2> /dev/null | awk '/^r[[:digit:]]+ \|/ { sub(/^r/,"",$1); print  $1 }'
