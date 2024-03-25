#!/bin/sh

if [ "${1}" == "pre" ]; then
    CURRENT_BRIGHTNESS=$(cat /sys/class/backlight/dp_backlight/brightness)
    echo $CURRENT_BRIGHTNESS > /tmp/curr_brightness
    echo "echo 0 > /sys/class/backlight/dp_backlight/brightness" | sudo sh
fi

if [ "${1}" == "post" ]; then
    sleep 0.8
    echo "echo off > /sys/class/drm/card1-DSI-1/status" | sudo sh
    sleep 0.4
    echo "echo on > /sys/class/drm/card1-DSI-1/status" | sudo sh

    sleep 0.5
    CURRENT_BRIGHTNESS=$(cat /tmp/curr_brightness)
    echo "echo '$CURRENT_BRIGHTNESS' > /sys/class/backlight/dp_backlight/brightness" | sudo sh
fi
