#!/bin/sh

if [ -f /tmp/hdmi_qc.txt ];then
	rm /tmp/hdmi_qc.txt
fi
if [ -f /tmp/edid_tmp ];then
        rm /tmp/edid_tmp
fi

res_org=`fbset |grep geometry |cut -d ' ' -f 5 --complement`
echo "$res_org" >/tmp/res.txt

hexdump /sys/devices/platform/display-subsystem/drm/card1/card1-HDMI-A-1/edid >/tmp/edid_tmp
edid_size=`du /tmp/edid_tmp | awk '{print $1}'`
if [ $edid_size == 0 ];then
	echo fail >/tmp/hdmi_qc.txt
	cat /tmp/hdmi_qc.txt
	return 1
else
	echo pass >/tmp/hdmi_qc.txt
fi

#fbset -fb /dev/fb0 -g 1920 1080 1920 1080 16

#fbset -fb /dev/fb0 -g $res_org

#kill -9 $$
