#!/bin/bash

# Calculation of the Lock screen informations
PRIMARY_SCREEN_WIDTH="$(xrandr | grep primary | grep -o '[0-9]\+x[0-9]\+' | grep -o '[0-9]\+' | head -1)"
PRIMARY_SCREEN_HEIGHT="$(xrandr | grep primary | grep -o '[0-9]\+x[0-9]\+' | grep -o '[0-9]\+' | tail -1)"
PRIMARY_SCREEN_X_OFFSET="$(xrandr | grep primary | grep -o '[+\-][0-9]\+[+\-][0-9]\+' | grep -o '[+\-][0-9]\+' | head -1)"
PRIMARY_SCREEN_Y_OFFSET="$(xrandr | grep primary | grep -o '[+\-][0-9]\+[+\-][0-9]\+' | grep -o '[+\-][0-9]\+' | tail -1)"
IND_RADIUS=15
MARGIN=24
IND_POS_X=$((PRIMARY_SCREEN_X_OFFSET + IND_RADIUS + MARGIN))
IND_POS_Y=$((PRIMARY_SCREEN_HEIGHT + PRIMARY_SCREEN_Y_OFFSET - IND_RADIUS - MARGIN))
TIME_WIDTH=400
TIME_HEIGHT=152
TIME_POS_X=$((PRIMARY_SCREEN_X_OFFSET + PRIMARY_SCREEN_WIDTH - TIME_WIDTH - MARGIN))
TIME_POS_Y=$((PRIMARY_SCREEN_Y_OFFSET + PRIMARY_SCREEN_HEIGHT - TIME_HEIGHT))
LOCK_CMD="i3lock --nofork --screen=0 --color=000000
	--insidevercolor=00000000 --insidewrongcolor=00000000 --insidecolor=00000000
	--ringvercolor=2C2C2CFF --ringwrongcolor=0A0A0AFF --ringcolor=0A0A0AFF
	--linecolor=00000000 --keyhlcolor=FFFFFFFF --bshlcolor=2C2C2CFF
	--textcolor=00000000 --veriftext= --wrongtext=
	--radius=$IND_RADIUS --indpos=$IND_POS_X:$IND_POS_Y
	--clock --timecolor=FFFFFFFF --timestr=%H:%M --timepos=$TIME_POS_X:$TIME_POS_Y --time-align=2
	--datecolor=666666FF --datestr=%A,\ %d.\ %B\ %Y --date-align=2"

DISPLAY_RE="([0-9]+)x([0-9]+)\\+([0-9]+)\\+([0-9]+)" # Regex to find display dimensions
FOLDER=`pwd` # Current folder
CACHE_FOLDER="$HOME/.config/i3/lock_cache/" # Cache folder"
if ! [ -e $CACHE_FOLDER ]; then
	mkdir $CACHE_FOLDER
fi
BKG_IMG="$HOME/.config/i3/lockscreen"  # Passed image
if ! [ -e "$BKG_IMG" ]; then
	eval $LOCK_CMD
	exit 0
fi

MD5_BKG_IMG=$(md5sum $BKG_IMG | cut -c 1-10)
MD5_SCREEN_CONFIG=$(xrandr | md5sum - | cut -c 1-32) # Hash of xrandr output
OUTPUT_IMG="$CACHE_FOLDER""$MD5_SCREEN_CONFIG"."$MD5_BKG_IMG".png # Path of final image
OUTPUT_IMG_WIDTH="$(xrandr | grep 'Screen 0' | grep -o 'current [0-9]\+ x [0-9]\+' | grep -o '[0-9]\+' | head -1)" # Decide size to cover all screens
OUTPUT_IMG_HEIGHT="$(xrandr | grep 'Screen 0' | grep -o 'current [0-9]\+ x [0-9]\+' | grep -o '[0-9]\+' | head -1)" # Decide size to cover all screens

LOCK_CMD="$LOCK_CMD --image $OUTPUT_IMG" # Image exist, show on lock screen

if [ -e $OUTPUT_IMG ]
then
	# Lock screen since image already exists
	eval $LOCK_CMD
	exit 0
fi

#Execute xrandr to get information about the monitors:
while read LINE
do
	#If we are reading the line that contains the position information:
	if [[ $LINE =~ $DISPLAY_RE ]]; then
		#Extract information and append some parameters to the ones that will be given to ImageMagick:
		SCREEN_WIDTH=${BASH_REMATCH[1]}
		SCREEN_HEIGHT=${BASH_REMATCH[2]}
		SCREEN_X=${BASH_REMATCH[3]}
		SCREEN_Y=${BASH_REMATCH[4]}

		CACHE_IMG="$CACHE_FOLDER""$SCREEN_WIDTH"x"$SCREEN_HEIGHT"."$MD5_BKG_IMG".png
		## if cache for that screensize doesnt exist
		if ! [ -e $CACHE_IMG ]
		then
			# Create image for that screensize
			eval convert '$BKG_IMG' '-resize' '${SCREEN_WIDTH}X${SCREEN_HEIGHT}^' '-gravity' 'Center' '-crop' '${SCREEN_WIDTH}X${SCREEN_HEIGHT}+0+0' '+repage' '$CACHE_IMG'
		fi

		# Decide size of output image
		if (( $OUTPUT_IMG_WIDTH < $SCREEN_WIDTH+$SCREEN_X )); then
			OUTPUT_IMG_WIDTH=$(($SCREEN_WIDTH+$SCREEN_X));
		fi;
		if (( $OUTPUT_IMG_HEIGHT < $SCREEN_HEIGHT+$SCREEN_Y )); then
			OUTPUT_IMG_HEIGHT=$(( $SCREEN_HEIGHT+$SCREEN_Y ));
		fi;

		PARAMS="$PARAMS $CACHE_IMG -geometry +$SCREEN_X+$SCREEN_Y -composite "
	fi
done <<<"`xrandr`"

#Execute ImageMagick:
eval convert -size ${OUTPUT_IMG_WIDTH}x${OUTPUT_IMG_HEIGHT} 'xc:black' $OUTPUT_IMG
eval convert $OUTPUT_IMG $PARAMS $OUTPUT_IMG

#Lock the screen:
eval $LOCK_CMD
