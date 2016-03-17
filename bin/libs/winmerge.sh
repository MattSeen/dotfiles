#!/bin/sh
echo Launching WinMergeU.exe: $1 $2
"WinMergeU.exe" -e -ub -dl "Base" -dr "Mine" "$1" "$2"
