#! /usr/bin/bash

git clone --no-checkout https://github.com/MattSeen/dotfiles.git dotfiles

pushd dotfiles > /dev/null
	git config core.worktree="../../"
	git checkout master
popd > /dev/null

