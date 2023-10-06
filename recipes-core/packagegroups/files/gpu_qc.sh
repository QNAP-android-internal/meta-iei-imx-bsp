#!/bin/sh

if [ -f /tmp/gpu_qc.txt ];then
	rm /tmp/gpu_qc.txt
fi
if [ -f /tmp/gpu_result.txt ];then
	rm /tmp/gpu_result.txt
fi

pass_score=$1
glmark2-es2-wayland --size 320x180 >/tmp/gpu_result.txt
score=`cat /tmp/gpu_result.txt |grep " glmark2 Score" |awk '{print $3}'`

if [ $score -ge $pass_score ];then
	echo pass >/tmp/gpu_qc.txt	
else
	echo fail >/tmp/gpu_qc.txt
fi
