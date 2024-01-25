#!/bin/sh

# RGB test
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

# Backlight test
BL_DEV=$(cat /proc/device-tree/model | tr -d '\000' | cut -d ' ' -f3)

for i in $(seq 1 100);
do
    if [ "$BL_DEV" = "B643" ]; then
        echo "$i" > /sys/class/backlight/dsi_backlight/brightness
    elif [ "$BL_DEV" =  "B664" ]; then
        echo "$i" > /sys/class/backlight/dp_backlight/brightness
    else
        echo "$i" > /sys/class/backlight/dsi_backlight/brightness
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
