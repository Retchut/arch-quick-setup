#!/bin/bash
OLD=$(cat /sys/class/backlight/intel_backlight/brightness)
NEW=$(($OLD+4000))
if [[ $NEW -gt 24000 ]]
then
    NEW=24000
fi
echo $NEW | sudo tee -a /sys/class/backlight/intel_backlight/brightness > /dev/null
