#!/usr/bin/env sh
if [[ $1 == "enable" ]]; then
	xset +dpms
 elif [[ $1 == "disable" ]]; then
	xset -dpms
else
	echo "please specify 'enable' or 'disable'"
fi
