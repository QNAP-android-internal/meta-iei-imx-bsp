#!/bin/sh
if [ -f /etc/lsb-release ]; then
	. /etc/lsb-release
	OS=$DISTRIB_ID
fi

# RGB test
if [ "$OS" = "Ubuntu" ]; then
        gst-launch-1.0 videotestsrc ! videoconvert ! glimagesink > /dev/null 2>&1 &
        sleep 3
        RGB_PID=$(pidof gst-launch-1.0 videotestsrc ! videoconvert ! glimagesinkk)
        kill -9 $RGB_PID
else
	weston-presentation-shm > /dev/null 2>&1 &
	RGB_PID=$(pidof weston-presentation-shm)
	sleep 3
	kill -9 $RGB_PID
	weston-presentation-shm > /dev/null 2>&1 &
	RGB_PID=$(pidof weston-presentation-shm)
	sleep 3
	kill -9 $RGB_PID
	weston-presentation-shm > /dev/null 2>&1 &
	RGB_PID=$(pidof weston-presentation-shm)
	sleep 3
	kill -9 $RGB_PID

	weston-simple-dmabuf-feedback > /dev/null 2>&1
fi
# Backlight test
BL_DEV=$(cat /proc/device-tree/model | tr -d '\000' | cut -d ' ' -f3)

for i in $(seq 1 100);
do
    if [ "$BL_DEV" = "B643" ]; then
        echo "echo '$i' > /sys/class/backlight/dsi_backlight/brightness" | sudo sh
    elif [ "$BL_DEV" =  "B664" ]; then
        echo "echo '$i' > /sys/class/backlight/dp_backlight/brightness" | sudo sh
    else
       echo "echo '$i' > /sys/class/backlight/dsi_backlight/brightness" | sudo sh
    fi

    sleep 0.1
done


sleep 0.5
sh -c 'dialog --colors --title "LCD Test" \
--no-collapse --yesno "RGB and Backlight test work?" 10 50'

LCD_RESULTS=$?

if [[ $LCD_RESULTS == '0' ]]; then
    echo "pass" > /tmp/edp_qc.txt
else
    echo "fail" > /tmp/edp_qc.txt
fi
