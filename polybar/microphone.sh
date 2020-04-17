#!/usr/bin/env sh
muted=$(pacmd list-sources | grep -e '\* index: ' -A 11 | grep 'muted' |  sed -e 's/\s*muted: //')
if [[ "$muted" == "yes" ]]; then
	echo ""
else
	echo ""
fi
