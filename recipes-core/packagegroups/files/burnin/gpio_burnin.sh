#!/bin/sh

SOC=`cat /proc/device-tree/model | cut -d ' ' -f3`
if [ $SOC == B643 ]; then
	echo "prepare to start"
else
	echo fail > /tmp/gpio_qc.txt
	exit
fi

if [ -f /etc/lsb-release ]; then
	. /etc/lsb-release
	OS=$DISTRIB_ID
fi

while true
do
	# check loopback 1-2
	if [ "$OS" = "Ubuntu" ]; then
		sudo gpioset gpiochip5 8=1
		GET_VAL=$(sudo gpioget gpiochip5 9)
	else
		gpioset gpiochip5 8=1
		GET_VAL=$(gpioget gpiochip5 9)
	fi
	if [[ "$GET_VAL" != 1 ]]; then
		echo "fail" > /tmp/gpio_qc.txt
		continue
	fi
	if [ "$OS" = "Ubuntu" ]; then
		sudo gpioset gpiochip5 8=0
		GET_VAL=$(sudo gpioget gpiochip5 9)
	else
		gpioset gpiochip5 8=0
		GET_VAL=$(gpioget gpiochip5 9)
	fi
	if [[ "$GET_VAL" != 0 ]]; then
		echo "fail" > /tmp/gpio_qc.txt
		continue
	fi


	# check loopback 3-4
	if [ "$OS" = "Ubuntu" ]; then
		sudo gpioset gpiochip5 10=1
		GET_VAL=$(sudo gpioget gpiochip5 11)
	else
		gpioset gpiochip5 10=1
		GET_VAL=$(gpioget gpiochip5 11)
	fi
	if [[ "$GET_VAL" != 1 ]]; then
		echo "fail" > /tmp/gpio_qc.txt
		continue
	fi
	if [ "$OS" = "Ubuntu" ]; then
		sudo gpioset gpiochip5 10=0
		GET_VAL=$(sudo gpioget gpiochip5 11)
	else
		gpioset gpiochip5 10=0
		GET_VAL=$(gpioget gpiochip5 11)
	fi
	if [[ "$GET_VAL" != 0 ]]; then
		echo "fail" > /tmp/gpio_qc.txt
		continue
	fi


	# check loopback 5-6
	if [ "$OS" = "Ubuntu" ]; then
		sudo gpioset gpiochip5 12=1
		GET_VAL=$(sudo gpioget gpiochip5 13)
	else
		gpioset gpiochip5 12=1
		GET_VAL=$(gpioget gpiochip5 13)
	fi
	if [[ "$GET_VAL" != 1 ]]; then
		echo "fail" > /tmp/gpio_qc.txt
		continue
	fi

	if [ "$OS" = "Ubuntu" ]; then
		sudo gpioset gpiochip5 12=0
		GET_VAL=$(sudo gpioget gpiochip5 13)
	else
		gpioset gpiochip5 12=0
		GET_VAL=$(gpioget gpiochip5 13)
	fi
	if [[ "$GET_VAL" != 0 ]]; then
		echo "fail" > /tmp/gpio_qc.txt
		continue
	fi

	# check loopback 7-8
	if [ "$OS" = "Ubuntu" ]; then
		sudo gpioset gpiochip5 14=1
		GET_VAL=$(sudo gpioget gpiochip5 15)
	else
		gpioset gpiochip5 14=1
		GET_VAL=$(gpioget gpiochip5 15)
	fi
	if [[ "$GET_VAL" != 1 ]]; then
		echo "fail" > /tmp/gpio_qc.txt
		continue
	fi

	if [ "$OS" = "Ubuntu" ]; then
		sudo gpioset gpiochip5 14=0
		GET_VAL=$(sudo gpioget gpiochip5 15)
	else
		gpioset gpiochip5 14=0
		GET_VAL=$(gpioget gpiochip5 15)
	fi
	if [[ "$GET_VAL" != 0 ]]; then
		echo "fail" > /tmp/gpio_qc.txt
		continue
	fi

	echo "pass" > /tmp/gpio_qc.txt
	fail_counter=0
	sleep 5
done
