#!/bin/bash
OLD=$(cat /sys/class/backlight/intel_backlight/brightness)
NEW=$(($OLD-1000))
if [[ $NEW -lt 0 ]]
then
    NEW=0
fi
echo $NEW | sudo tee -a /sys/class/backlight/intel_backlight/brightness > /dev/null