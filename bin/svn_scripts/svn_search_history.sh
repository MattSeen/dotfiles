#!/bin/env bash
# Usage: svn_search_history @filename @search_text

SCRIPTNAME="$(basename $0)";

if [ "$#" -lt 2 ]; then
    echo -e "You did not provide the correct number of parameters \n";
    echo -e "Correct usage: $SCRIPTNAME <FILEPATH> <SEARCH TERM> [--no-grep-output] [--grep-context <LINE CONTEXT>] [--grep-flags <ANY GREP FLAGS>]";
    echo -e "NOTE: Passing the --grep-context flag will take the param next to it and place in the grep -C flag \n";
    echo -e "TIP: Using --grep-flags and standard grep regex you can find any kind of pattern in a file over time.";
    echo -e "TIP: Passing a blank search term and --no-grep-output will show you the file growth over time... nifty huh? \n";
    echo -e "Example: $SCRIPTNAME './Roster.js' 'x=y' --no-grep-output";
    exit;
fi

filename=$1
searchText=$2
printGrepOutput=true;

# Default to 0 which means it'll only print the line it finds.
grepContext=0;
grepFlags="";
grepContextFlagPassed=false;
grepContextFlagValuePos=;
grepGeneralFlagPassed=false
grepGeneralFlagValuePos=;

count=0
for var in "$@"
do
    echo "DEBUG: Param at position $count: $var";

    if [ "$var" == "--no-grep-output" ]; then
        printGrepOutput=false;
    fi

    # TODO: Put in the ability to pass in --grep-context... will have to find the value next to that flag
    if [ "$var" == "--grep-context" ]; then
        grepContextFlagPassed=true;
        grepContextFlagValuePos=$((count+1));
    fi

    if [ "$grepContextFlagPassed" == true ] && [ $count -eq $grepContextFlagValuePos ]; then
        echo "DEBUG: The --grep-context flag was passed... extract data from position: $grepContextFlagValuePos"
        grepContextFlagPassed=false;
        grepFlags="$grepFlags -C $var";
    fi

    if [ "$var" == "--grep-flags" ]; then
        grepGeneralFlagPassed=true;
        grepGeneralFlagValuePos=$((count+1));
    fi

    if [ "$grepGeneralFlagPassed" == true ] && [ $count -eq $grepGeneralFlagValuePos ]; then
        echo "DEBUG: The --grep-flags flag was passed... extract data from position: $grepGeneralFlagValuePos"
        grepGeneralFlagPassed=false;
        grepFlags="$grepFlags $var";
    fi

    ((count++));
done

echo -e "INFO: The grep flags are going to be: $grepFlags\n";

# TODO: Eventually should let them pass in their own flags
for r in $(svn log -q "$filename" | grep '^r' | awk '{print $1;}'); do
  grepOutput=$(svn cat -r $r "$filename" | cat -n | grep $grepFlags "$searchText")
  if [[ -n "$grepOutput" ]]; then

    finalMessage="Found in revision $r [matched length $(echo "$grepOutput" | wc -l)]";
	if $printGrepOutput; then
        finalMessage="$finalMessage: \n\n $grepOutput \n";
    fi

	echo -e "$finalMessage";
  fi
done
