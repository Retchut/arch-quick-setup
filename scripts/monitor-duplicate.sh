
#!/bin/bash
#mirror monitor 2 to monitor 1, where monitor 2 will be scaled so the image has monitor 1's resolution
xrandr --output [monitor 1] --mode [resx1]x[resy1] --output [monitor 2] --same-as [monitor 1] --scale `echo "[resx1]/[resx2]" | bc -l`x`echo "[resy1]/[resy2]" | bc -l`
~/.fehbg
