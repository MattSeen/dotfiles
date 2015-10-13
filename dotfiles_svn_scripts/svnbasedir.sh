#!/bin/sh
# Usage:  svnbase
# Output: Print the location of the .svn folder/base of this checkout

svn info | sed -n "/Working Copy Root Path\: /s///p"
