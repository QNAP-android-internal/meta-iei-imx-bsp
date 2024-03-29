#!/bin/sh

if [ -f /etc/lsb-release ]; then
	. /etc/lsb-release
	OS=$DISTRIB_ID
fi

if [ "$OS" = "Ubuntu" ]; then
	sd_path=`ls /media/ubuntu/`
	test_video_path=/media/ubuntu/$sd_path/test_video.mp4

	if ! [ -f $test_video_path ];then
		echo "fail" > /tmp/video_qc.txt
		exit
	fi

	gst-launch-1.0 filesrc location=$test_video_path ! qtdemux name=demux demux.video_0 !  vpudec ! glimagesink render-rectangle='<1,1,160,90>'
else
	sd_path=$(mount | grep mmcblk1 | awk -F' ' '{print $3}')
	test_video_path=$sd_path/test_video.mp4

        if ! [ -f $test_video_path ];then
	        echo "fail" > /tmp/video_qc.txt
	        exit
        fi

        gst-launch-1.0 filesrc location=$test_video_path typefind=true \
        ! video/quicktime ! aiurdemux ! queue max-size-time=0 \
        ! vpudec ! waylandsink
fi


sh -c 'dialog --colors --title "Video Test" \
--no-collapse --yesno "See the vdieo??" 10 50'

video_result=$?

if [[ "$video_result" == '1' ]]; then
    echo "fail" > /tmp/video_qc.txt
elif [[ "$video_result" == '0' ]]; then
    echo "pass" > /tmp/video_qc.txt
fi
