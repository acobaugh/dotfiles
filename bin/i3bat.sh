#!/usr/bin/env bash

while true ; do
	paste /sys/class/power_supply/BAT?/uevent | awk '{split($0,a,"="); split(a[2],b," "); (a[3] == "Charging" || b[1] == "Charging") ? $5 = "Charging" : $5 = (a[3] + b[1])/2; print a[1] "=" $5}' > /tmp/.i3uevent
	sleep 5
done
