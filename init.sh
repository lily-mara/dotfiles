#!/bin/sh

for file in *.symlink; do
	LINK_NAME=$(echo "$file" | sed -e "s/\.symlink$//" -e "s|^|${HOME}/.|")
	LINK_TARGET=$(readlink -f "$file")

	if [ -e "$LINK_NAME" ]; then
		echo "$LINK_NAME" exists, backing up to "$LINK_NAME".bak
		mv "$LINK_NAME" "$LINK_NAME".bak
	fi

	ln -s "$LINK_TARGET" "$LINK_NAME"
done
