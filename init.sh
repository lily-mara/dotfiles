#!/bin/sh

find -maxdepth 1 -type d -not -name '.*' -exec stow {} \;
