#!/usr/bin/env sh
for file in "$@"; do
	datetimeoriginal="$(exiftool -DateTimeOriginal -S -d %Y%m%d_%H%M%S "$file" | cut -d " " -f 2)"
	filename="$(basename -- "$file")"
	extension="${filename##*.}"
	newfilename="$datetimeoriginal"
	if [[ ! -z "$datetimeoriginal" ]]; then
		newfilenamewithsuffix="$newfilename"
		suffix=1
		while [[ -e "$newfilenamewithsuffix.$extension" ]]; do
			newfilenamewithsuffix="$newfilename-$suffix"
			suffix=$((suffix + 1))
		done
		mv "$file" "$newfilenamewithsuffix.$extension"
	else
		echo "Cannot move $file: No DateTimeOriginal set"
	fi
done
