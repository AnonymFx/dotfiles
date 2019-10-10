#!/usr/bin/env zsh
CURRENT=$(cat /sys/class/power_supply/BAT0/current_now)
VOLTAGE=$(cat /sys/class/power_supply/BAT0/voltage_now)
echo $((CURRENT * VOLTAGE / 1000000000000.0))
