#!/bin/bash
# Usage: svngrep $regex @grep_args

regex="$@"
pattern=`echo $regex | perl -p -e 's/--?\S+//g; s/^\\s+//;'` # strip --args
if [[ ! $regex ]]; then
    echo "Usage: svngrep \$regex @grep_args"
else 
    for file in `grep -irl --no-messages --exclude=\*.tmp --exclude=\.svn $regex ./`;     do 
        revs="`svnrevisions.sh $file`";
        for rev in $revs; do
            diff=`svn diff $file -r$[rev-1]:$rev \
                 --diff-cmd /usr/bin/diff -x "-Ew -U5 --strip-trailing-cr" 2> /dev/null`
            context=`echo "$diff" \
                 | grep -i --color=none   -U5 "^\(+\|-\).*$pattern" \
                 | grep -i --color=always -U5             $pattern  \
                 | grep -v '^+++\|^---\|^===\|^Index: ' \
                 `
            if [[ $context ]]; then
                info=`echo "$diff" | grep '^+++\|^---'`
                log=`svn log $file -r$rev`
                #author=`svn info -r$rev | awk '/Last Changed Author:/ { print $4 }'`; 

                echo "========================================================================"
                echo "========================================================================"
                echo "$log"
                echo "$info"
                echo "$context"
                echo
            fi;
        done;
    done;
fi