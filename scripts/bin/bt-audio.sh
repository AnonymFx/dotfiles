#!/usr/bin/env sh

# Resolve device name
bt_mac=""
case $2 in
	"jabra" )
		bt_mac="70:BF:92:A9:E9:C7"
		;;
	"logitech" )
		bt_mac="04:AA:00:11:3A:2E"
		;;
	"sony" )
		bt_mac="CC:98:8B:93:95:B2"
		;;
	"jbl" )
		bt_mac="B8:D5:0B:EA:A7:8E"
		;;
esac

# Print error if device name was not found
if [[ ! "$bt_mac" ]]; then
	cat <<-EOF
		Cannot find device "$2" among
		    logitech
		    sony
		    shure
		    jbl
	EOF
	exit
fi

# Add reconnect functionality, bluetoothctl does not support it natively
if [[ "$1" == "reconnect" ]]; then
	bluetoothctl disconnect "$bt_mac" > /dev/null 2>&1 && sleep 1 && bluetoothctl connect "$bt_mac" > /dev/null 2>&1
else
	bluetoothctl $1 "$bt_mac" > /dev/null 2>&1
fi

# Error handling for bluetooth commands
if [[ ! $? -eq 0 ]]; then
	echo "Bluetooth command \"$1\" unsuccessful, please refer to bluetoothctl help for more info"
	exit
fi

# If everything went smoothly, enable pulseaudio equalizer after connects and reconnects
if [[ $1 == "connect" || $1 == "reconnect" ]]; then
	# Wait for the bt-audio connection to be the standard sink
	sleep 5
	pulseaudio-equalizer enable
fi
