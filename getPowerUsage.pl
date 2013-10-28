#!/usr/bin/perl -w
=comment header
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
 *  getPowerUsage.pl is part of the EcoManager project.
 *  getPowerUsage.pl reads data from a EDF EcoManager electricity monitor
 *  (Current Cost) device via usb serial port and displays the current 
 *  power usage.
 *
 *  Project     : EcoManager
 *  Git Repo    : https://github.com/prae5/EcoManager
 *  Project Site: 
 *  Author      : Paul Rae
 *  Email       : paul@paulrae.com
 *  Website     : www.paulrae.com
 */
=cut

use strict;
use Device::SerialPort qw( :PARAM :STAT 0.07 );
use XML::LibXML;

my $PORT = "/dev/ttyUSB0";

my $ob = Device::SerialPort->new($PORT);
$ob->baudrate(57600);
$ob->write_settings;

my $debug=$ARGV[0];

open(SERIAL, "+>$PORT");
while (my $line = <SERIAL>) {
#    print "Debug Data Dump:\n";
#    print $line;
#    print "End Debug Dump\n\n";

    if ( $debug eq "debug") {
        print "Debug Data Dump:\n";
        print $line;
        print "End Debug Dump\n\n";
    } 

    my $parser = XML::LibXML->new();
    my $xmldoc = $parser->parse_string($line);

    for my $sample ($xmldoc->findnodes('/msg')) {
        for my $property ($sample->findnodes('./*')) {
            print $property->nodeName(), ": ", $property->textContent(), "\n";
        }
        print "\n";
    }

exit;
}


