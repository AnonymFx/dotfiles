#!/usr/bin/env sh
yay -Syy > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
	yay -Qu 2>/dev/null | wc -l
else
	echo -
fi

