#!/usr/bin/env bash
function isSupportedImageFile() {
	local filename="$1"
	[[ "$filename" =~ \.(jpg|JPG|jpeg|JPEG)$ ]]
}

num_renamed=0
num_failed=0
for image in "$@"; do
	filename=$(basename -- "$image")

	if ! isSupportedImageFile "$filename"; then
		continue
	fi

	stripped="${filename%.*}"
	datestring=$(expr "$stripped" : '.*\([0-9]\{8\}[-_][0-9]\{6\}\).*')
	if [[ -z "$datestring" ]]; then
		continue
	fi

	formatted="${datestring:0:4}:${datestring:4:2}:${datestring:6:2} ${datestring:9:2}:${datestring:11:2}:${datestring:13:2}"
	if exiftool -DateTimeOriginal="$formatted" "$image" > /dev/null; then
		num_renamed=$((num_renamed+1))
	else
		num_failed=$((num_failed+1))
	fi
done

echo "Renamed: $num_renamed, Failed: $num_failed"
if (( num_failed > 0 )); then
	exit 1
fi
