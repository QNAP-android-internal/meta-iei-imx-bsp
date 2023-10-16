#!/bin/sh

if [ -f /tmp/bt_qc.txt ];then
        rm /tmp/bt_qc.txt
fi

if [ -f /tmp/btctl_scan.txt ];then
        rm /tmp/btctl_scan.txt
fi

echo fail >/tmp/bt_qc.txt

bt_firmware_path=/lib/firmware/BCM4362A2_001.003.006.1045.1053.hcd
baudrate=115200

#move init to rc.local
#brcm-patchram-plus  --enable_hci --no2bytes --use_baudrate_for_download --tosleep 200000 --baudrate $baudrate --patchram $bt_firmware_path /dev/ttymxc0 &
#rfkill list |grep -A2 hci0 |grep yes
#if [ $? == 0 ];then
#	rfkill_list_no=`rfkill list |grep hci0 |cut -d ":" -f1`
#	rfkill unblock $rfkill_list_no
#fi
#hciconfig hci0 up
#bluetoothctl power on
#bluetoothctl agent on
fail_count=0
while true
do
	bluetoothctl scan on >/tmp/btctl_scan.txt &
	btctl_scan_pid=`ps -F |grep "bluetoothctl scan on" |grep -v "grep" |awk '{print $2}'`
	sleep 5
	kill $btctl_scan_pid
	sleep 5
	cat /tmp/btctl_scan.txt |grep "NEW" |awk '{print $3}'>/tmp/bt_mac.txt
	bt_mac=`shuf -n1 /tmp/bt_mac.txt`
	if [[ -z "$bt_mac" ]];then
		sleep 5
		continue
	fi

	bluetoothctl info $bt_mac >/tmp/bt_info.txt
	cat /tmp/bt_info.txt |grep "Device $mac" |grep -v "not available"
	if [ $? == 0 ];then
		fail_count=0
		echo pass >/tmp/bt_qc.txt
	else
		fail_count=$(($fail_count+1))
	fi
	if [ $fail_count -ge 3 ];then
		echo fail >/tmp/bt_qc.txt
	fi
	sleep 10
done
