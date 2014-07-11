#!/bin/sh

eval $(gpg-agent --daemon)
xscreensaver -no-splash &
xmodmap -e "pointer = 3 2 1"
