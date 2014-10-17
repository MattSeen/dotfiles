<h1>Do not use this dotfiles set yet, as it's not fully tested!</h1>

Introduction
============

Up until recently I had been managing my git and bash configuration through git gist. I reached a point recently (when I had to change my PC at work) where I realised that that no longer made sense. So I have created this dotfiles repository to coordinate my effort.

Windows
=======

I use a windows machine so these scripts are targeted there using msysgit.

3rd Party Code and Tools Directory
==================================

I use a number of 3rd party open source projects/scripts. They can be found primary under the "tools/" directory (the stuff there is managed using git subtree), but some other scripts in this repo also happen to come from different locations. The URL to those tools and scripts are as follows:

- Bashmarks: https://github.com/twerth/bashmarks.git ( Thanks for a great script [@twerth](https://github.com/twerth/) :) )
- Git prompt and auto completion: https://github.com/git/git/tree/master/contrib/completion
- Arcanist auto completion: https://github.com/phacility/arcanist/tree/master/resources/shell
- Rake task auto completion: https://gist.github.com/turadg/840663 ( Thanks for a great script [@turadg](https://gist.github.com/turadg/) :) )
	- I actually forked that gist and made some updates.


TODO
====

- [ ] Test
- [ ] Creating an install script (symbolic links of some kind after checkout)
- [ ] Get git scripts from work machine
- [ ] Get git templates from work machine
- [ ] Error for scripts that aren't present or might mess up
- [ ] List of necessary tools on the environmental path
