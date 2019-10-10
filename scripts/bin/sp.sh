#/usr/bin/env sh
positional=()
prepend_date=""

# Parse arguments
while [[ $# -gt 0 ]]; do
	key="$1"
	case $key in
		-d )
			prepend_date="true"
			shift
			;;
		* )
			positional+=("$1")
			shift
			;;
	esac
done

if [[ "${#positional[@]}" -lt 1 ]]; then
	echo No scratchpad files provided.
	exit
fi

# Generate scratchpad files
scratchpad_files=()
for file in "${positional[@]}"; do
	filename="$(basename $file)"
	path="$(dirname $file)"

	if [[ "$filename" == *.scratchpad.md ]]; then
		# Substring from 0 to $(sizeof ".scratchpad.md")
		filename="${filename:0:-14}"
	fi

	if [[ "$filename" =~ [0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])_.* ]]; then
		prepend_date=""
	fi

	scratchpad_path="$path/"
	if [[ ! -z "$prepend_date" ]]; then
		scratchpad_path+="$(date +%F)_"
	fi
	scratchpad_path+="$filename"
	scratchpad_path+=".scratchpad.md"

	scratchpad_files+=("$scratchpad_path")
done

# Open files
$EDITOR "${scratchpad_files[@]}"
