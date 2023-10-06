#!/bin/sh

test_video=$1
if ! [ -f $test_video ];then
	echo "fail" > /tmp/video_qc.txt
	exit
fi

 gst-launch-1.0 filesrc location=$test_video typefind=true \
! video/quicktime ! aiurdemux ! queue max-size-time=0 \
! vpudec ! waylandsink

sh -c 'dialog --colors --title "Video Test" \
--no-collapse --yesno "See the vdieo??" 10 50'

video_result=$?

if [[ "$video_result" == '1' ]]; then
    echo "fail" > /tmp/video_qc.txt
elif [[ "$video_result" == '0' ]]; then
    echo "pass" > /tmp/video_qc.txt
fi
