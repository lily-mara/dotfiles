#!/bin/sh

cd ~/git/dotfiles
git add .bash_aliases
git commit -m "$1"
git push
