#!/bin/sh

echo "fail" > /tmp/video_qc.txt

if [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
fi

if [ ${OS} = "Ubuntu" ] ;then
        sd_path=`ls /media/ubuntu/`
        test_video_path=/media/ubuntu/$sd_path/test_video.mp4
        if ! [ -f $test_video_path ];then
                echo "fail" > /tmp/video_qc.txt
                exit
        fi
        while true
        do
                sudo gst-launch-1.0 filesrc location=$test_video_path ! qtdemux name=demux demux.video_0 !  vpudec ! glimagesink render-rectangle='<1,1,360,240>'
                echo "pass" > /tmp/video_qc.txt
        done
else
        sd_path=$(mount | grep mmcblk1 | awk -F' ' '{print $3}')
	test_video_path=$sd_path/test_video.mp4
	if ! [ -f $test_video_path ];then
                echo "fail" > /tmp/video_qc.txt
                exit
        fi

        while true
        do
                gst-launch-1.0 filesrc location=$test_video_path typefind=true \
                ! video/quicktime ! aiurdemux ! queue max-size-time=0 \
                ! vpudec ! waylandsink window-width=320 window-height=180
                echo "pass" > /tmp/video_qc.txt
        done
fi

