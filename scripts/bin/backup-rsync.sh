#!/usr/bin/env zsh
if [[ $# < 2 ]]; then
	echo Please provide a source and destination
fi
rsync --archive --info=progress2 "$1/" "$2"
# find "$2" -type f -name "._*" -print0 | while IFS= read -r -d '' file;
# do
# 	# TODO: To fix umlauts, go to the folder and just do a rm ._* For some reason that doesn't work with a folder before the glob pattern
# 	[[ -f "$file" ]] && rm -f "$file"
# done
