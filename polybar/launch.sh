#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch primarybar and secondarybar
# Get primary monitor and set environment variable to load the primary bar on this monitor
THERMAL_ZONE=0
if [ -e ~/.config/polybar/thermal_zone ]; then
	read THERMAL_ZONE < ~/.config/polybar/thermal_zone
fi
WLAN="$(ls /sys/class/net | grep wl)" \
ETH="$(ls /sys/class/net | grep en)" \
BAT="$(ls /sys/class/power_supply | grep BAT)" \
BAT_ADP="$(ls /sys/class/power_supply | grep "A[CD].*")" \
MONITOR="$(xrandr -q | grep -e 'primary' | cut -d " " -f1 | head -n 1)" \
THERMAL_ZONE=$THERMAL_ZONE \
polybar primarybar &
# Show the default bar for other monitors connected
while read -r monitor; do
    MONITOR=$monitor \
    polybar secondarybar &
done <<< "$(xrandr -q | grep -e ' connected' | grep -v 'primary' | cut -d ' ' -f1)"

echo "Bars launched..."
