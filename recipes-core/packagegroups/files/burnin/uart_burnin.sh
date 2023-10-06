#!/bin/sh

if [ -f /tmp/uart_qc_$1.txt ];then
        rm /tmp/uart_qc_$1.txt
fi

if [ -f /tmp/uart_tmp_$1.txt ];then
        rm /tmp/uart_tmp_$1.txt
fi
echo "fail" > /tmp/uart_qc_$1.txt
if [ $# -ge 2 ] && [ $2 -gt 0 ];then
	baudrate=$2
else
	boudrate=9600
fi
test_str=123

uart_path=/dev/$1
echo "uart_path=$uart_path"

#for stty -F /dev/ttymxc2 115200 will stuck 
#after cat /dev/ttymxc2 > /tmp/tmp.txt &
#so just use default boudrate in ttymxc2
#############################################
if [ $1 != ttymxc2 ];then
	echo "boudrate=$boudrate"
	stty -F $uart_path $boudrate
fi
#############################################
cat $uart_path > /tmp/uart_tmp_$1.txt &

while true
do
	cat $uart_path > /tmp/uart_tmp_$1.txt &
	sleep 2
	cat_pid=`ps -F |grep "cat $uart_path" |grep -v grep | awk  '{print $2}'`
	ps |grep "cat $uart_path" |grep -v grep

	# echo string
	echo $test_str > $uart_path
	sleep 2
	cat /tmp/uart_tmp_$1.txt |grep $test_str
	if [ $? == 0  ];then
		echo "pass" > /tmp/uart_qc_$1.txt
	else
		echo "fail" > /tmp/uart_qc_$1.txt
	fi
	> /tmp/uart_tmp_$1.txt
	kill -9 $cat_pid
	sleep 5
done
