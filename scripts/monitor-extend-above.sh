#!/bin/bash
#extend monitor 2 above monitor 1, both with the desired resolution and not scaled
#xrandr --output [monitor 1] --mode [res1x]x[res1y] --scale 1 --output [monitor 2] --mode [res2x]x[res2y] --above [monitor 1] --scale 1
xrandr --output eDP-1 --mode 1920x1080 --scale 1 --output HDMI-1-0 --mode 1920x1080 --above eDP-1 --scale 1
~/.fehbg
