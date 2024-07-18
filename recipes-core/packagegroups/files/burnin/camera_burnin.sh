#!/bin/sh

export TERM=linux
export XDG_RUNTIME_DIR=/run/user/$UID/

if [ $(ls $1) ]; then
	echo "pass" > /tmp/camera_qc.txt
else
	echo "fail" > /tmp/camera_qc.txt
fi

if [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
fi

if [ ${OS} = "Ubuntu" ] ;then
	python3 /home/root/machine_learning/MLDemoLauncher.py detect
else
	gst-launch-1.0 v4l2src device=/dev/video3 ! \
	'video/x-raw,format=YUY2,width=1280,height=720,pixel-aspect-ratio=1/1,framerate=30/1' ! \
	 waylandsink window-height=180 window-width=320
fi
