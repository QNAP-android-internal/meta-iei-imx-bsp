#!/bin/sh

if [ -f /tmp/gpu_result.txt ];then
	rm /tmp/gpu_result.txt
fi

echo pass >/tmp/gpu_qc.txt

if [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
fi

if [ ${OS} = "Ubuntu" ] ;then
	sudo glmark2-es2-wayland --size 320x180 --run-forever
else
	glmark2-es2-wayland --size 320x180 --run-forever
fi
