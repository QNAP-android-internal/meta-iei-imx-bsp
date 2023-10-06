#!/bin/sh

test_video=$1
if ! [ -f $test_video ];then
	echo "fail" > /tmp/video_qc.txt
	exit
fi

echo "fail" > /tmp/video_qc.txt
while true
do
	gst-launch-1.0 filesrc location=$test_video typefind=true \
	! video/quicktime ! aiurdemux ! queue max-size-time=0 \
	! vpudec ! waylandsink window-width=320 window-height=180
	echo "pass" > /tmp/video_qc.txt	
done
