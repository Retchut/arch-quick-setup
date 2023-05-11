#!/bin/bash
#mirror monitor 1 to monitor 2, where monitor 1 will be scaled so the image has monitor 2's resolution
#xrandr --output [monitor 2] --mode [res2x]x[res2y] --output [monitor 1] --same-as [monitor 2] --scale `echo "[res2x]/[res1x]" | bc -l`x`echo "[res2y]/[res1y]" | bc -l`
xrandr --output HDMI-0 --mode 1920x1080 --output eDP-1-1 --same-as HDMI-0 --scale `echo "1920/1920" | bc -l`x`echo "1080/1080" | bc -l`
~/.fehbg
