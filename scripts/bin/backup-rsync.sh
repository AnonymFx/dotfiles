#!/usr/bin/env zsh
if [[ $# < 2 ]]; then
	echo Please provide a source and destination
fi
rsync --recursive --info=progress2 "$1/" "$2"
find "$2" -type f -name "._*" -delete
