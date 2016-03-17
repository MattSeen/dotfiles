#!/bin/bash
# The following script creates a directory which will be a state where a rename
# will cause a conflict on either a rebase or a merge.
# This will allow you to test out the this script. 

testDir="newDir"
testFileName="README.txt"
subDir="different/directory/"
testFileName_renamed="newfilename.md"

newTestFileName=$(echo $subDir$testFileName_renamed)

master="master"
testBranchName="OTHER_BRANCH"

# INIT

rm -fR $testDir
mkdir $testDir

cd $testDir
git init --template="."

touch $testFileName

git add $testFileName
git commit -m "Init on master"

# Base commmit to master

echo "NOISE" >> $testFileName
git commit -am "NOISE commit"

# Setup branch off of master 

git checkout -b $testBranchName --track $master

echo "other branch" >> $testFileName
echo "other branch" >> $testFileName
echo "other branch" >> $testFileName
git commit -am "OTHER_BRANCH commit 1"

# Cause branches to diverge by renaming a file and committing to master

git checkout $master

mkdir -p $subDir

git mv $testFileName $newTestFileName

git commit -m "Renamed that file son."

echo "NOISE" >> $newTestFileName
git commit -am "NOISE commit"

echo "NOISE" >> $newTestFileName
git commit -am "NOISE commit"

# Go back to the alterate branch and commit content there.

git checkout $testBranchName

echo "new content!" >> $testFileName
git commit -am "OTHER_BRANCH commit 2"

echo "new content!" >> $testFileName
git commit -am "OTHER_BRANCH commit 3"

# Now do a rebase or merge (best to do this manually)
