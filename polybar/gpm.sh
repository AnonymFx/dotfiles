#!/bin/bash

maxlen=$1

# requires jq to work
if !hash jq 2>/dev/null; then
	echo "please install 'jq'";
fi
# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=" "

GMPDIR="$(cat ${HOME}/.config/Google\ Play\ Music\ Desktop\ Player/json_store/playback.json)"

getitem() {
	item=$1
	echo "$(echo ${GMPDIR} | jq ${item} | sed 's/"//g')"
}

title="$(getitem '.song.title')"
artits="$(getitem '.song.artist')"
album="$(getitem '.song.album')"
liked="$(getitem '.rating.liked')"
if [[ $liked = 'true' ]]; then
	liked=""
else
	liked=""
fi
# tcurrent="$(getitem '.time.current')"
# ttotal="$(getitem '.time.total')"

# mseconds="$(($ttotal - $tcurrent))"
# seconds="$(($mseconds / 1000))"
# tsec="$(($seconds%60))"
# tsec="$(printf %02d $tsec)"
# # (( $tsec < 10 )) && $tsec="0$tsec";
# tmin="$(($seconds/60%60))"
# remain="$tmin:$tsec"

player_status="$(getitem '.playing')"

# Show max 1/3 of the length the author and on the rest the title
maxauthorlen=$((maxlen/3))
authorlen=${#author}
if [[ authorlen -gt maxauthorlen ]]; then
	authorlen = maxauthorlen
fi
titlelen=$((maxlen - authorlen))

# Cut output to maxlen
if [[ ${#artist} -gt authorlen ]]; then
	title="$(echo $artits | head -c $((titlelen-3)))..."
fi

if [[ ${#title} -gt titlelen ]]; then
	title="$(echo $title | head -c $((titlelen-3)))..."
fi

metadata="$title - $artits"

# Foreground color formatting tags are optional
if [[ $player_status = "true" ]]; then
	echo "$icon $metadata"
elif [[ $player_status = "false" ]]; then
	echo ""
fi
