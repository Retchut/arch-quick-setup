#!/bin/bash

# pause play symbols    
getmedia(){
        echo ""
}

# more icons       (  :vol mute not showing up)
getvolume(){
	# each SINK comes in the format: "AIII"
	# where A is an asterisk (active sink) or a blank (inactive)
	# and III is the sink index
	for SINK in `pacmd list-sinks | grep 'index:' | cut -b 3,12-`;
	do
        	# if the first character is an asterisk
        	if [ "$(echo $SINK | cut -b 1)" == "*" ]
        	then
                	# active sink
        	        INDEX="$(echo $SINK | cut -b 2-)"
	                VOL="$(echo $(pactl get-sink-volume $INDEX | awk '{ print $5 }' ))"
                	echo " $VOL"
        	fi
	done
}

getbattery(){
	BAT=$(cat /sys/class/power_supply/BAT?/capacity)
	CHG=$(cat /sys/class/power_supply/BAT?/status)
	
	# if the laptop is plugged in
	if [[ $CHG == "Charging" || $CHG == "Full" ]]
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

getnetwork(){
    WIFI_STRENGTH=$(grep "^\s*w" /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')

	# if we're connected via an ethernet cable
	# alternative icon for ethernet if I'm feeling particularly cute that day:
	if [ $(cat /sys/class/net/e*/operstate) == "up" ]
	then
        	echo ""
	elif [ -z $WIFI_STRENGTH ]
	then
        	echo ""
	else
        	echo " $WIFI_STRENGTH%"
	fi
}

getdate(){
	dt=$(date +"%H:%M | %A, %d/%m/%Y")
	echo $dt
}

while :; do

	# build status bar
	status=" $(getnetwork) | $(getvolume) | $(getbattery) | $(getdate)"

	# update status bar
	xsetroot -name "$status"

	# sleep for 30 seconds before updating again
	# the forcestatusupdate.sh script kills this script and reruns it
	sleep 30s
done

# | media | volume | battery | internet | date
