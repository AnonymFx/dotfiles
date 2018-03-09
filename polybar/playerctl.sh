#!/bin/bash
if [ "$(playerctl status 2>/dev/null)" = "Playing" ]; then
	maxlen=$1
	title=`exec playerctl metadata xesam:title 2>/dev/null`
	artist=`exec playerctl metadata xesam:artist 2>/dev/null`

	# Show max 1/3 of the length the author and on the rest the title
	maxartistlen=$((maxlen/3))
	artistlen=${#artist}
	if [[ artistlen -gt maxartistlen ]]; then
		artistlen=$maxartistlen
	fi
	titlelen=$((maxlen - artistlen))

	# Cut output to maxlen
	if [[ ${#artist} -gt artistlen ]]; then
		artist="$(echo $artits | head -c $((artistlen-3)))..."
	fi

	if [[ ${#title} -gt titlelen ]]; then
		title="$(echo $title | head -c $((titlelen-3)))..."
	fi

	echo "$title - $artist"
else if [ "$(playerctl status 2>/dev/null)" = "Paused" ]; then
	echo ""
fi
fi
