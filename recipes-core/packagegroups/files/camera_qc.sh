#!/bin/sh

export TERM=linux
export XDG_RUNTIME_DIR=/run/user/$UID/


if [ $(ls $1) ]; then
    echo "ov5640 driver existed, starting test"
else
    echo "fail" > /tmp/camera_qc.txt
fi


gst-launch-1.0 v4l2src device=/dev/video3 ! 'video/x-raw,format=YUY2,width=1280,height=720,pixel-aspect-ratio=1/1,framerate=30/1' !  waylandsink & 

sleep 5

gst_pid=`ps -F |grep gst-launch |grep -v grep |awk '{print $2}'`
kill -9 $gst_pid

sh -c 'dialog --colors --title "Camera Test" \
--no-collapse --yesno "See the image??" 10 50'

CAMERA_RESULTS="$?"
if [[ "$CAMERA_RESULTS" == '1' ]]; then
    echo "fail" > /tmp/camera_qc.txt
elif [[ "$CAMERA_RESULTS" == '0' ]]; then
    echo "pass" > /tmp/camera_qc.txt
fi
