#!/usr/bin/env zsh
if [[ $# < 2 ]]; then
	echo Please provide a source and destination
fi
# rsync archive mode without l (copy symlinks as symlinks), d (device files), p (permissions) but with --update and --info
rsync --recursive --times --group --owner --update --info=progress2 "$1/" "$2"
find "$2" -type f -iname "._*"
