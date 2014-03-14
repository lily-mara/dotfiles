#!/bin/sh

cd ~/.dotfiles
git add aliases
git commit -m "$1"
git push
