#!/bin/sh

if [ -f /tmp/wifi_qc.txt ];then
	rm /tmp/wifi_qc.txt
fi

if [ -f /tmp/wifiscan_tmp.txt ];then
        rm /tmp/wifiscan_tmp.txt
fi

echo fail > /tmp/wifi_qc.txt

for i in $(seq 1 10);
do
	if [ -f /tmp/modem_qc.txt ];then
		break
	else
		if [ $i == 10 ];then
			systemctl stop NetworkManager
			sleep 2
		fi
	fi
	sleep 1
done

fail_count=0
while true
do
	connmanctl disable wifi 
	connmanctl enable wifi 
	sleep 3

	connmanctl scan wifi 
	sleep 5
	connmanctl services > /tmp/wifiscan_tmp.txt
	sync

	cat /tmp/wifiscan_tmp.txt |grep "wifi_"
	if [ $? == 1 ];then
		fail_count=$(($fail_count+1))
	else
		fail_count=0
		echo pass > /tmp/wifi_qc.txt
	fi
	if [ $fail_count -ge 3 ];then
		echo fail > /tmp/wifi_qc.txt
	fi
	sleep 10
done
