#!/bin/sh

if [ -f /tmp/gpu_result.txt ];then
	rm /tmp/gpu_result.txt
fi

echo pass >/tmp/gpu_qc.txt

glmark2-es2-wayland --size 320x180 --run-forever

