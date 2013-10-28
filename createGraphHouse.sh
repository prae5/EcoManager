#!/bin/bash

RRDFILE="/etc/EcoManager/EcoManager.rrd"
IMGPATH="/var/cache/munin/www/power"
PERIOD=$1

ALL="Entire House"
IAM1="(Bigbox NAS)"
IAM2="(Microserver)"
IAM3="(Buildbox)"

rrdtool graph $IMGPATH/house-power$PERIOD.png \
--start end-$PERIOD --width 700 --end now --slope-mode \
--vertical-label Watts --lower-limit 0 \
--alt-autoscale-max \
--title "Entire House Power Consumption" \
--watermark "`date`" \
DEF:Power=$RRDFILE:Power:AVERAGE \
LINE2:Power#0000FF:"House" \
COMMENT:" \n" \
COMMENT:" $ALL Usage\: " \
GPRINT:Power:MIN:" Minimum\:%4.0lfW" \
GPRINT:Power:MAX:" Maximum\:%4.0lfW" \
GPRINT:Power:AVERAGE:" Average\:%4.0lfW\n" \



