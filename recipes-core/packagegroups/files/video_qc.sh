#!/bin/sh

sd_path=`ls /run/media/ |grep ^mmc`
test_video_path=/run/media/$sd_path/test_video.mp4
if ! [ -f $test_video_path ];then
	echo "fail" > /tmp/video_qc.txt
	exit
fi

 gst-launch-1.0 filesrc location=$test_video_path typefind=true \
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
