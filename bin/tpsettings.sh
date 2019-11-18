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
    #echo -n 65 | sudo tee $TPDEV/speed # def 97 on t450s
    #echo -n 5   | sudo tee $TPDEV/drift_time # def 5 on t450s
    echo -n 150 | sudo tee $TPDEV/sensitivity # def 200 on t450s
    echo -n 75 | sudo tee $TPDEV/rate # def 100 on t450s
    echo -n 1 | sudo tee $TPDEV/inertia
    echo -n 255 | sudo tee $TPDEV/resolution
else
    echo "Couldn't find trackpoint device $TPDEV"
fi
