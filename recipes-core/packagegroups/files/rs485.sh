#!/bin/sh

if [ -f /tmp/testUSB0.txt ];then
	rm /tmp/testUSB0.txt
fi
if [ -f /tmp/testmxc2.txt ];then
	rm /tmp/testmxc2.txt
fi

#ttymxc2 TX
gpioset gpiochip4 8=1
#ttyUSB0 RX
gpioset gpiochip6 2=0

test_str=mxc2toUSB0
while true
do
	cat /dev/ttyUSB0 > /tmp/testUSB0.txt &
	sleep 2
	pid=`ps -F |grep "cat /dev/ttyUSB0" |grep -v grep | awk  '{print $2}'`
	echo $test_str >/dev/ttymxc2
	sleep 2
	cat /tmp/testUSB0.txt |grep $test_str
	if [ $? == 0  ];then
		echo pass
		kill -9 $pid
		break
	else
		kill -9 $pid
		sleep 3
		continue
	fi
done

#ttymxc2 RX
gpioset gpiochip4 8=0
#ttyUSB0 TX
gpioset gpiochip6 2=1

test_str=USB0tomxc2
while true
do
	cat /dev/ttymxc2 > /tmp/testmxc2.txt &
	sleep 2
	pid=`ps -F |grep "cat /dev/ttymxc2" |grep -v grep | awk  '{print $2}'`
	echo $test_str >/dev/ttyUSB0
	sleep 2
	cat /tmp/testmxc2.txt |grep $test_str
	if [ $? == 0  ];then
        	echo pass
		kill -9 $pid
		break
	else
		kill -9 $pid
		sleep 3
        	continue
	fi
done
