#!/usr/bin/env sh
function print_help() {
	echo "drive-open file.gddoc|file.gdsheet|file.gdslides"
}
if [[ $# != 1 ]]; then
	print_help
fi

path=$1
filename=$(basename -- "$path")
extension="${filename##*.}"

if [[ ! -e "$path" && ! ("$extension" == "gddoc" || "$extension" == "gdsheet" || "$extension" == "gdslides") ]]; then
	print_help
fi

document_link=$(jq -r '.url' "$path")
firefox "$document_link"
