#!/bin/sh
if [ "${1}" == "post" ]; then
	ifconfig eth0 down
	ifconfig eth1 down
	ifconfig eth0 up
	ifconfig eth1 up
fi
