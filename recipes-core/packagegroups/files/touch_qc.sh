#!/bin/sh

rm -f /tmp/touch_qc.txt

# Get touch screen device via the command
device_path=$(weston-touch-calibrator |& grep device |& awk -F' ' '{print $2}')
# Remove the leading and trailing quotes
device_path=${device_path#\"}
device_path=${device_path%\"}

if [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        OS=$DISTRIB_ID
fi

if [ "$OS" = "Ubuntu" ]; then
	xinput_calibrator
else
	weston-touch-calibrator $device_path
fi

sh -c 'dialog --colors --title "Touch Test" \
--no-collapse --yesno "Touch Drawing works??" 10 50'

TOUCH_RESULTS=$?

if [[ "$TOUCH_RESULTS" == '1' ]]; then
    echo "fail" > /tmp/touch_qc.txt

elif [[ "$TOUCH_RESULTS" == '0' ]]; then
    echo "pass" > /tmp/touch_qc.txt
fi
