#!/bin/sh

SOC=`cat /proc/device-tree/model | cut -d ' ' -f3`

log_org_path=/qc/log.txt

time=`date "+%Y-%m-%d %H:%M:%S"`
time_for_filename=`echo $time |sed s/\ /_/g |sed s/-//g |sed s/://g`
kernel=`uname -r`

while read line
do
	echo $line |grep ":pass"
	if [ $? != 0 ];then
		check_result=false
		break
	else
		check_result=true
	fi
done </tmp/result.txt

if $check_result;then
	log_name=${time_for_filename}_Pass.txt
else
	log_name=${time_for_filename}_Fail.txt
fi
log_path=/qc/$log_name

#echo $log_path
cp $log_org_path $log_path ;sync
sed -i -e "s/Time :/Time : $time/g" $log_path ;sync
sed -i -e "s/Kernal version :/Kernal version : $kernel/g" $log_path ;sync
cat /tmp/result.txt >> $log_path ;sync
