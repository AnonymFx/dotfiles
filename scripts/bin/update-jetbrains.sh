#!/usr/bin/env sh
function print_help() {
	cat <<- EOF
		Usage: update-jetbrains <update_dir> <target_dir>
	EOF
}

POSITIONAL=()
while [[ $# -gt 0 ]]; do
	key=$1
	case $key in
		-h|--help )
			print_help
			exit
			;;
		* )
			POSITIONAL+=("$1")
			shift
			;;
	esac
done

if [[ ${#POSITIONAL[@]} -lt 2 ]]; then
	echo "Too few arguments"
	print_help
	exit
fi

UPDATE_DIR="${POSITIONAL[0]}"
TARGET_DIR="${POSITIONAL[1]}"
DO_COPY_PROPERTIES=""

if [[ ! -d "$UPDATE_DIR" ]]; then
	echo "Directory $UPDATE_DIR doesn't exist"
	exit
fi

# Backup idea.properties
if [[ -e "$TARGET_DIR/bin/idea.properties" ]]; then
	DO_COPY_PROPERTIES="TRUE"
	cp "$TARGET_DIR/bin/idea.properties" /tmp
fi

# Perform the update
if [[ -d "$TARGET_DIR" ]]; then
	rm -r "$TARGET_DIR"
fi
cp -r "$UPDATE_DIR" "$TARGET_DIR"

chmod -R 775 "$TARGET_DIR"
sudo chown -R root:users "$TARGET_DIR"


# Restore idea.properties
if [[ $DO_COPY_PROPERTIES ]]; then
	cp /tmp/idea.properties "$TARGET_DIR/bin/idea.properties"
fi

