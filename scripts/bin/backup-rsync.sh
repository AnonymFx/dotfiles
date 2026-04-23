#!/usr/bin/env bash
if [[ $# -lt 2 ]]; then
	echo "Please provide a source and destination"
	exit 1
fi
rsync --archive --info=progress2 "$1/" "$2"
