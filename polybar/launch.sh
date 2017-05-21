#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
# Get primary monitor and set environment variable to load the primary bar on this monitor
MONITOR="$(xrandr -q | grep -e 'primary' | cut -d " " -f1 | head -n 1)" polybar bar1 &
# Show the default bar for other monitors connected
while read -r monitor; do
    MONITOR=$monitor polybar bar2 &
done <<< "$(xrandr -q | grep -e ' connected' | grep -v 'primary' | cut -d ' ' -f1)"

echo "Bars launched..."
