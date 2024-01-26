#!/bin/sh

sd_path=$(mount | grep mmcblk1 | awk -F' ' '{print $3}')
test_video_path=$sd_path/test_video.mp4
if ! [ -f $test_video_path ];then
	echo "fail" > /tmp/video_qc.txt
	exit
fi

echo "fail" > /tmp/video_qc.txt
while true
do
	gst-launch-1.0 filesrc location=$test_video_path typefind=true \
	! video/quicktime ! aiurdemux ! queue max-size-time=0 \
	! vpudec ! waylandsink window-width=320 window-height=180
	echo "pass" > /tmp/video_qc.txt	
done
