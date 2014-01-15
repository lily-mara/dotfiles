#!/bin/sh

## creates all of the symlinks for dotfiles in this folder ##

this_folder=`pwd`
dotfiles=`ls | grep -v '\.swp$'`

for i in $dotfiles
do
	echo linking $i
	ln -s $this_folder/$i ~/.$i
done
