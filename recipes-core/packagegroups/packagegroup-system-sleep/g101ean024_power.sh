#!/bin/sh

if [ "${1}" == "pre" ]; then
    CURRENT_BRIGHTNESS=$(cat /sys/class/backlight/dp_backlight/brightness)
    echo $CURRENT_BRIGHTNESS > /tmp/curr_brightness
    echo 0 > /sys/class/backlight/dp_backlight/brightness
fi

if [ "${1}" == "post" ]; then
    sleep 0.8
    echo off > /sys/class/drm/card1-DSI-1/status
    sleep 0.4
    echo on > /sys/class/drm/card1-DSI-1/status

    sleep 0.2
    CURRENT_BRIGHTNESS=$(cat /tmp/curr_brightness)
    echo "$CURRENT_BRIGHTNESS" > /sys/class/backlight/dp_backlight/brightness
fi
