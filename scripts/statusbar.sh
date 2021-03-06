#!/bin/bash

getmedia(){
	STATE="$(mocp -i | grep "State: " | cut -b 8-)"
	MEDIA=""	

	if [[ $STATE == "STOP"  ]]
        then
                MEDIA=""
        else
		if [[ $STATE == "PAUSE" ]]
		then
			MEDIA=""
		elif [[ $STATE == "PLAY" ]]
		then
			MEDIA=""
		fi
		
		SONG="$(mocp -i | grep "SongTitle: " | cut -b 11-)"
		ARTIST="$(mocp -i | grep "Artist: " | cut -b 9-)"

		# show the file name if the song has no title
		if [[ "$SONG" == "" || "$SONG" == " " ]]
		then
			SONG="$(mocp -i | grep "File: " | cut -b 34-)"
		fi

		MEDIA="$MEDIA $SONG ($ARTIST)"
	fi

	echo $MEDIA
}

getfanprofile(){
	STATUS=$(asusctl profile -p | cut -b 19-)
	STATUS=${STATUS?}
	echo " $STATUS"
}

getnetwork(){
	WIFI_STRENGTH=$(grep "^\s*w" /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
	NETWORK=$(nmcli connection show)
	NETWORK=$(echo $NETWORK | awk '{ print $5 }')

	# if we're connected via an ethernet cable
	# alternative icon for ethernet if I'm feeling particularly cute that day:
	if [ $(cat /sys/class/net/e*/operstate) == "up" ]
	then
        	echo ""
	elif [ -z $WIFI_STRENGTH ]
	then
        	echo ""
	else
        	echo " $NETWORK"
	fi
}

getmicmute(){
	# check if the microphone is muted
	# the default source is the currently active one
	if [ "$(pactl get-source-mute @DEFAULT_SOURCE@ | cut -b 7-)" == "yes" ]
	then
		echo " "
	fi
}

getvolume(){
	ICON=""
	VOL=$(pactl get-sink-volume @DEFAULT_SINK@  | awk '{ print $5 }')
	
	# the default sink is the currently active one
	if [ "$(pactl get-sink-mute @DEFAULT_SINK@ | cut -b 7-)" == "yes" ]
	then
		ICON=" "
	else
		if [ $VOL == "0%" ]
		then
			ICON=" "
		elif [ $(echo $VOL | cut -d% -f1) -gt 50 ]
		then
			ICON=" "
		else
			ICON=" "
		fi
	fi

	echo "$ICON$VOL"
}

getbrightness(){
	BRIGHT=$(cat /sys/class/backlight/intel_backlight/brightness)
	MAX_BRIGHT=$(cat /sys/class/backlight/intel_backlight/max_brightness)
	PERCENT=$(($BRIGHT*100/$MAX_BRIGHT))
	echo " $PERCENT%"
}

getbattery(){
	BAT=$(cat /sys/class/power_supply/BAT?/capacity)
	CHG=$(cat /sys/class/power_supply/BAT?/status)
	
	# if the laptop is plugged in
	if [[ $CHG == "Charging" || $CHG == "Not charging" ]]
	then
		echo  "$BAT"%

	else
		if [[ $BAT -gt 90 || $BAT == 90 ]]
		then
			echo  "$BAT"%
		elif [[ ($BAT -lt 90 && $BAT -gt 65) || $BAT == 65 ]]
		then
			echo  "$BAT"%
		elif [[ ($BAT -lt 65 && $BAT -gt 35) || $BAT == 35 ]]
		then
			echo  "$BAT"%
		elif [[ ($BAT -lt 35 && $BAT -gt 10) || $BAT == 10 ]]
		then
			echo  "$BAT"%
		else
			echo  "$BAT"%
		fi	

	fi
}

getdate(){
	dt=$(date +"%H:%M | %A, %d/%m/%Y")
	echo $dt
}

while :; do

	# build status bar
	status=" $(getmedia) | $(getfanprofile) | $(getnetwork) | $(getmicmute)$(getvolume) | $(getbrightness) | $(getbattery) | $(getdate)"

	# update status bar
	xsetroot -name "$status"

	# sleep for 30 seconds before updating again
	# the forcestatusupdate.sh script kills this script and reruns it
	sleep 30s
done
