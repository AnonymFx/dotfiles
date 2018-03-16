#!/bin/bash
playerstatus="$(playerctl status 2>/dev/null)"
if [ "$playerstatus" == "Playing" ]; then
	maxlen=$1
	maxlen=$((maxlen - 3)) # Include the separator " - " in maxlen calculations

	title=`exec playerctl metadata xesam:title 2>/dev/null`
	titlelen=${#title}
	artist=`exec playerctl metadata xesam:artist 2>/dev/null`
	artistlen=${#artist}

	# Show max 1/3 of the length the author and on the rest the title
	maxartistlen=$((maxlen/3))
	# Or, if the title is very short, allow a longer artist
	if [ $((maxlen - titlelen)) -gt $maxartistlen ]; then
		maxartistlen=$((maxlen - titlelen))
	fi

	if [[ $artistlen -gt $maxartistlen ]]; then
		artistlen=$maxartistlen
	fi
	titlelen=$((maxlen - artistlen))

	# Cut output to maxlen
	if [[ ${#artist} -gt $artistlen ]]; then
		artist="$(echo $artist | head -c $((artistlen-3)))..."
	fi

	if [[ ${#title} -gt titlelen ]]; then
		title="$(echo $title | head -c $((titlelen-3)))..."
	fi

	echo "$title - $artist"
else
	echo ""
fi
