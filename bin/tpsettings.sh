#!/usr/bin/env bash

# When run from a udev rule, DEVPATH should be set
if [ ! -z $DEVPATH ] ; then
    TPDEV=/sys/$( echo "$DEVPATH" | sed 's/\/input\/input[0-9]*//' )
else
# Otherwise just look in /sys/
    TPDEV=$(find /sys/devices -name name | xargs grep -Fl TrackPoint | sed 's/\/input\/input[0-9]*\/name$//')
fi

# http://www.thinkwiki.org/wiki/How_to_configure_the_TrackPoint
# http://wwwcssrv.almaden.ibm.com/trackpoint/files/ykt3eext.pdf
#------------------------------------------------------------
if [ -d "$TPDEV" ]; then
    echo "Configuring Trackpoint"
    echo -n 140 | sudo tee $TPDEV/sensitivity
    echo -n 65 | sudo tee $TPDEV/speed
    echo -n 5   | sudo tee $TPDEV/drift_time
else
    echo "Couldn't find trackpoint device $TPDEV"
fi