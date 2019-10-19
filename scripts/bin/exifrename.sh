#!/usr/bin/env sh
for file in $@; do
	datetimeoriginal="$(exiftool -DateTimeOriginal -S -d %Y%m%d_%H%M%S "$file" | cut -d " " -f 2)"
	filename=$(basename -- "$file")
	extension="${filename##*.}"
	newfilename="$datetimeoriginal.$extension"
	if [[ ! -z $datetimeoriginal ]]; then
		if [[ ! -e "$newfilename" ]]; then
			mv "$file" "$newfilename"
		else
			echo Cannot move $file: $newfilename already exists
		fi
	else
		echo "Cannot move $file: No DateTimeOriginal set"
	fi
done
