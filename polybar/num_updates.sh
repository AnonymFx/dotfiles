#!/usr/bin/env sh
updates="$(yay -Qu 2>/dev/null)"
if [[ $? -eq 0 ]]; then
	echo $($updates | wc -l)
else
	echo -
fi

