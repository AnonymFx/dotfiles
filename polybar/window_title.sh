#!/bin/sh
max_len=25
window_title="$(xdotool getactivewindow getwindowname 2>/dev/null)" 
if  [[ $? -gt 0 ]]; then
	echo ""
	exit
fi

window_title_short=$(echo "$window_title" | grep -oP ".*? -" | head -1)
if [[ ! -z "$window_title_short" ]]; then
	window_title="$window_title_short"
	window_title=${window_title::-2}
fi

if [[ ${#window_title} -gt $max_len ]]; then
	window_title="${window_title:0:$((max_len-1))}…"
fi

echo $window_title

