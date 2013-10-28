#!/bin/bash

RRDFILE="/etc/EcoManager/EcoManager.rrd"
IMGPATH="/var/cache/munin/www/power"
PERIOD=$1

ALL="Entire House"
IAM1="(Bigbox NAS)"
IAM2="(Microserver)"
IAM3="(Buildbox)"

rrdtool graph $IMGPATH/iam-power$PERIOD.png \
--start end-$PERIOD --width 700 --end now --slope-mode \
--vertical-label Watts --lower-limit 0 \
--alt-autoscale-max \
--title "Individual Appliance (IAM) Power Consumption" \
--watermark "`date`" \
DEF:Power=$RRDFILE:Power:AVERAGE \
DEF:IAM1=$RRDFILE:IAM1:AVERAGE \
DEF:IAM2=$RRDFILE:IAM2:AVERAGE \
DEF:IAM3=$RRDFILE:IAM3:AVERAGE \
LINE2:IAM1#0000FF:"IAM1" \
LINE2:IAM2#CC00FF:"IAM2" \
LINE2:IAM3#FF9900:"IAM3" \
COMMENT:" \n" \
COMMENT:" $ALL Usage\: " \
GPRINT:Power:MIN:" Minimum\:%4.0lfW" \
GPRINT:Power:MAX:" Maximum\:%4.0lfW" \
GPRINT:Power:AVERAGE:" Average\:%4.0lfW\n" \
COMMENT:"   IAM1 $IAM1" \
GPRINT:IAM1:MIN:" Minimum\:%4.0lfW" \
GPRINT:IAM1:MAX:" Maximum\:%4.0lfW" \
GPRINT:IAM1:AVERAGE:" Average\:%4.0lfW\n" \
COMMENT:"   IAM2 $IAM2" \
GPRINT:IAM2:MIN:" Minimum\:%4.0lfW" \
GPRINT:IAM2:MAX:" Maximum\:%4.0lfW" \
GPRINT:IAM2:AVERAGE:" Average\:%4.0lfW\n" \
COMMENT:"   IAM3 $IAM3" \
GPRINT:IAM3:MIN:" Minimum\:%4.0lfW" \
GPRINT:IAM3:MAX:" Maximum\:%4.0lfW" \
GPRINT:IAM3:AVERAGE:" Average\:%4.0lfW\n" \



