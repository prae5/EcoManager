#!/bin/sh

/*
 *      Copyright (C) 2008-2013 Paul Rae
 *      http://www.paulrae.com
 *
 *  This Program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  This Program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  If not, see <http://www.gnu.org/licenses/>
 *
 *
 *  createRRD.sh is part of the EcoManager project.
 *  createRRD.sh creates the EcoManager data directory and creates
 *  the rrd datbase file that stores the electricity usage from a
 *  EDF EcoManager electricity monitor (Current Cost) device.
 *
 *  Project     : EcoManager
 *  Git Repo    : https://github.com/prae5/EcoManager
 *  Project Site: 
 *  Author      : Paul Rae
 *  Email       : paul@paulrae.com
 *  Website     : www.paulrae.com
 */

RRDPATH="/etc/EcoManager"
RRDFILE="EcoManager.rrd"

if [ ! -e "$RRDPATH/$RRDFILE" ]; then
    echo "create file"
    mkdir -p $RRDPATH
    chmod a+w $RRDPATH
rrdtool create EcoManager.rrd --step 60 \
DS:Power:GAUGE:240:0:U \
DS:IAM1:GAUGE:240:0:U \
DS:IAM2:GAUGE:240:0:U \
DS:IAM3:GAUGE:240:0:U \
DS:IAM4:GAUGE:240:0:U \
DS:IAM5:GAUGE:240:0:U \
DS:IAM6:GAUGE:240:0:U \
DS:IAM7:GAUGE:240:0:U \
DS:IAM8:GAUGE:240:0:U \
DS:IAM9:GAUGE:240:0:U \
DS:IAM10:GAUGE:240:0:U \
DS:IAM11:GAUGE:240:0:U \
DS:IAM12:GAUGE:240:0:U \
DS:IAM13:GAUGE:240:0:U \
DS:IAM14:GAUGE:240:0:U \
RRA:AVERAGE:0.5:1:3200 \
RRA:AVERAGE:0.5:6:3200 \
RRA:AVERAGE:0.5:36:3200 \
RRA:AVERAGE:0.5:144:3200 \
RRA:AVERAGE:0.5:1008:3200 \
RRA:AVERAGE:0.5:4320:3200 \
RRA:AVERAGE:0.5:52560:3200 \
RRA:AVERAGE:0.5:525600:3200 \
RRA:MIN:0.5:1:3200 \
RRA:MIN:0.5:6:3200 \
RRA:MIN:0.5:36:3200 \
RRA:MIN:0.5:144:3200 \
RRA:MIN:0.5:1008:3200 \
RRA:MIN:0.5:4320:3200 \
RRA:MIN:0.5:52560:3200 \
RRA:MIN:0.5:525600:3200 \
RRA:MAX:0.5:1:3200 \
RRA:MAX:0.5:6:3200 \
RRA:MAX:0.5:36:3200 \
RRA:MAX:0.5:144:3200 \
RRA:MAX:0.5:1008:3200 \
RRA:MAX:0.5:4320:3200 \
RRA:MAX:0.5:52560:3200 \
RRA:MAX:0.5:525600:3200
else
    echo "$RRDPATH/$RRDFILE already exists";
fi



