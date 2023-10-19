#!/bin/sh

export TERM=linux
export XDG_RUNTIME_DIR=/run/user/$UID/

headset_test()
{
	sh -c 'dialog --colors --title "Headset Test" \
	--no-collapse --msgbox "\nStart test when you choose \"OK\" \nListening about 5 secs..." 10 50 2>&1'
	
	arecord -D hw:$AUD_CARD -f dat | aplay -D hw:$AUD_CARD -f dat &
	sleep 5
	
	REC_PID=$(ps | grep arecord | head -1 | awk  '{print $1}')
	PLAY_PID=$(ps | grep aplay | head -1 | awk  '{print $1}')

	sh -c 'dialog --colors --title "Headset Test" \
	--no-collapse --yesno "Hear loopback sound?" 10 50 2>&1'

	if [ $? == 0 ];then
		echo "pass" > /tmp/audio_headset_qc.txt
	else
		echo "fail" > /tmp/audio_headset_qc.txt
	fi
	kill -9 $REC_PID
	kill -9 $PLAY_PID
	dd if=/dev/zero of=/dev/fb0
	kill -9 $$
}

DMIC_loopback_test()
{
	sh -c 'dialog --colors --title "DMIC Loopback Test" \
	--no-collapse --msgbox "\nStart test when you choose \"OK\" \nListening about 5 secs...\nPlease plug-out headset first" 10 50 \
	2>&1'

	#B643 do not have dmic
	if [ $SOC == "B664" ];then
		amixer -c 0 sset 'Mono ADC' '127'
		amixer -c 0 sset 'STO1 ADC Boost Gain' '0'
		arecord -D hw:$AUD_CARD -f dat -c1 | aplay -D hw:$AUD_CARD -f dat -c1 &
		REC_PID=$(ps | grep arecord | head -1 | awk  '{print $1}')
		PLAY_PID=$(ps | grep aplay | head -1 | awk  '{print $1}')
		kill -9 $REC_PID
		kill -9 $PLAY_PID
		arecord -D hw:$AUD_CARD -f dat | aplay -D hw:$AUD_CARD -f dat &
		sleep 5
	
		REC_PID=$(ps | grep arecord | head -1 | awk  '{print $1}')
		PLAY_PID=$(ps | grep aplay | head -1 | awk  '{print $1}')
	else
		echo "fail" > /tmp/audio_dmic_loopback_qc.txt
		return
	fi
	sh -c 'dialog --colors --title "DMIC Loopback Test" \
	--no-collapse --yesno "Hear sound?" 10 50 2>&1'
	
	if [ $? == 0 ];then
		echo "pass" > /tmp/audio_dmic_loopback_qc.txt
	else
		echo "fail" > /tmp/audio_dmic_loopback_qc.txt
	fi
	kill -9 $REC_PID
	kill -9 $PLAY_PID

	dd if=/dev/zero of=/dev/fb0
	kill -9 $$
}

speaker_test()
{
	#louder test wav for speaker-test
	if [ $SOC == "B664" ];then
		cp /usr/share/sounds/alsa/Front_Left_new.wav /usr/share/sounds/alsa/Front_Left.wav
		cp /usr/share/sounds/alsa/Front_Right_new.wav /usr/share/sounds/alsa/Front_Right.wav
		sync
	fi

	sh -c 'dialog --colors --title "Speaker Test" \
	--no-collapse --msgbox "\nStart test when you choose \"OK\" \nListening about 5 secs...\nPlease plug-out headset first" 10 50 \
	2>&1'
	speaker-test -t wav -c 2 -D hw:$AUD_CARD &
	sleep 5
	
	SPK_PID=$(ps | grep speaker-test | head -1 | awk  '{print $1}')

	sh -c 'dialog --colors --title "DMIC/Speaker Test" \
	--no-collapse --yesno "Hear sound?" 10 50 2>&1'
	
	if [ $? == 0 ];then
		echo "pass" > /tmp/audio_speaker_qc.txt
	else
		echo "fail" > /tmp/audio_speaker_qc.txt
	fi

	kill -9 $SPK_PID
	dd if=/dev/zero of=/dev/fb0
	kill -9 $$
}

SOC=`cat /proc/device-tree/model | cut -d ' ' -f3`
AUD_CARD=`cat /proc/asound/cards |grep 5672 |grep :|awk  '{print $1}'`

if [ -d /sys/class/i2c-dev/i2c-2/device/2-001c/ ]; then
    echo "codec existed, starting test"
else
	echo "fail" > /tmp/audio_headset_qc.txt
	echo "fail" > /tmp/audio_dmic_loopback_qc.txt
	echo "fail" > /tmp/audio_speaker_qc.txt
	exit 1
fi

case $1 in
	headset)
		headset_test
		;;
	DMIC)
		DMIC_loopback_test
		;;
	speaker)
		speaker_test
		;;
esac
