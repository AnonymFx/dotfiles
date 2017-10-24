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

# Cut output to maxlen
if [[ ${#title} -gt $((maxlen/2)) ]]; then
	title="$(echo $title | head -c $((maxlen/2-3)))..."
fi

if [[ ${#artist} -gt $((maxlen/2)) ]]; then
	title="$(echo $artits | head -c $((maxlen/2-3)))..."
fi

metadata="$title - $artits"

# Foreground color formatting tags are optional
if [[ $player_status = "true" ]]; then
	echo "$icon $metadata"
else
	echo ""
fi
