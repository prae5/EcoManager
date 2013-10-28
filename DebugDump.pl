#!/usr/bin/perl -w

# Reads data from a EDF EcoManager (Current Cost) device via usb serial port.

use strict;
use Device::SerialPort qw( :PARAM :STAT 0.07 );

my $PORT = "/dev/ttyUSB0";

my $ob = Device::SerialPort->new($PORT);
$ob->baudrate(57600);
$ob->write_settings;

open(SERIAL, "+>$PORT");
while (my $line = <SERIAL>) {
    print "Debug Data Dump:\n";
    print $line;
    print "End Debug Dump\n\n";
}

