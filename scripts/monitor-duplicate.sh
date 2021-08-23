
#!/bin/bash
#mirror monitor 1 to monitor 2, where monitor 1 will be scaled so the image has monitor 2's resolution
xrandr --output [monitor 2] --mode [res2x]x[res2y] --output [monitor 1] --same-as [monitor 2] --scale `echo "[res2x]/[res1x]" | bc -l`x`echo "[res2y]/[res1y]" | bc -l`
~/.fehbg
