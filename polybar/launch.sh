#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR="$(xrandr -q | grep -e 'primary' | cut -d " " -f1 | head -n 1)" polybar bar1 &
MONITOR="$(xrandr -q | grep -e ' connected' | grep -v 'primary' | cut -d ' ' -f1 | sed '1q;d')" polybar bar2 &
MONITOR="$(xrandr -q | grep -e ' connected' | grep -v 'primary' | cut -d ' ' -f1 | sed '2q;d')" polybar bar3 &

echo "Bars launched..."
