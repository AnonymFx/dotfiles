#!/bin/sh
window_title="$(xdotool getactivewindow getwindowname)"

window_title_short=$(echo "$window_title" | grep -oP ".*? -" | head -1)
if [[ ! -z "$window_title_short" ]]; then
	window_title="$window_title_short"
fi

echo ${window_title::-2} | cut -c 1-42

