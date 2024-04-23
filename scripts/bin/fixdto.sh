#!/bin/bash
function isSupportedImageFile() {
	expr "$1" : '.*\.jpg\|JPG\|jpeg\|JPEG$' > /dev/null
	echo $?
}

num_renamed=0
num_failed=0
for image in $@; do
	filename=$(basename -- "$image")
	extension="${filename##*.}"
	filename="${filename%.*}"
	dirname="$(dirname -- $image)"

	datestring=`expr "$filename" : '.*\([0-9]\{8\}[-_][0-9]\{6\}\).*'`
	if [[ "$datestring" ]] && [[ ! "$(exiftool -DateTimeOriginal $image)" ]] && [[ "$(isSupportedImageFile "$image")" -ne 0 ]]; then
		exiftool -DateTimeOriginal="${datestring:0:4}:${datestring:4:2}:${datestring:6:2} ${datestring:9:2}:${datestring:11:2}:${datestring:13:2}" "$image" > /dev/null
		if [[ $? ]]; then
			num_renamed=$((num_renamed+1))
		else
			num_failed=$((num_failed+1))
		fi
	fi
done

exit $num_failed
