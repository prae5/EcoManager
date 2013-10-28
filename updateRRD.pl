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
 *  updateRRD.pl is part of the EcoManager project.
 *  updateRRD.pl reads data from an EDF EcoManager electricity monitor
 *  and stores the data in an rrd database for graphing.
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
my $RRDFILE="/etc/EcoManager/EcoManager.rrd";

my $ob = Device::SerialPort->new($PORT);
$ob->baudrate(57600);
$ob->write_settings;

# Whole House & IAM Vars
my $chH;
my $ch01;
my $ch02;
my $ch03;
my $ch04;
my $ch05;
my $ch06;
my $ch07;
my $ch08;
my $ch09;
my $ch10;
my $ch11;
my $ch12;
my $ch13;
my $ch14;

# Read power usage from serial
open(SERIAL, "+>$PORT");
while (my $line = <SERIAL>) {

    my $parser = XML::LibXML->new();
    my $xmldoc = $parser->parse_string($line);

    # chH (Whole House Power)
    for my $sample ($xmldoc->findnodes('/msg/chH')) {
        for my $property ($sample->findnodes('./*')) {
            $chH = $property->textContent(),;
        }
    }

    # ch01 (IAM01)
    for my $sample ($xmldoc->findnodes('/msg/ch01')) {
        for my $property ($sample->findnodes('./*')) {
            $ch01 = $property->textContent(),;
        }
    }

    # ch02 (IAM02)
    for my $sample ($xmldoc->findnodes('/msg/ch02')) {
        for my $property ($sample->findnodes('./*')) {
            $ch02 = $property->textContent(),;
        }
    }

    # ch03 (IAM03)
    for my $sample ($xmldoc->findnodes('/msg/ch03')) {
        for my $property ($sample->findnodes('./*')) {
            $ch03 = $property->textContent(),;
        }
    }

    # ch04 (IAM04)
    for my $sample ($xmldoc->findnodes('/msg/ch04')) {
        for my $property ($sample->findnodes('./*')) {
            $ch04 = $property->textContent(),;
        }
    }

    # ch05 (IAM05)
    for my $sample ($xmldoc->findnodes('/msg/ch05')) {
        for my $property ($sample->findnodes('./*')) {
            $ch05 = $property->textContent(),;
        }
    }

    # ch06 (IAM06)
    for my $sample ($xmldoc->findnodes('/msg/ch06')) {
        for my $property ($sample->findnodes('./*')) {
            $ch06 = $property->textContent(),;
        }
    }

    # ch07 (IAM07)
    for my $sample ($xmldoc->findnodes('/msg/ch07')) {
        for my $property ($sample->findnodes('./*')) {
            $ch07 = $property->textContent(),;
        }
    }

    # ch08 (IAM08)
    for my $sample ($xmldoc->findnodes('/msg/ch08')) {
        for my $property ($sample->findnodes('./*')) {
            $ch08 = $property->textContent(),;
        }
    }

    # ch09 (IAM09)
    for my $sample ($xmldoc->findnodes('/msg/ch09')) {
        for my $property ($sample->findnodes('./*')) {
            $ch09 = $property->textContent(),;
        }
    }

    # ch10 (IAM10)
    for my $sample ($xmldoc->findnodes('/msg/ch10')) {
        for my $property ($sample->findnodes('./*')) {
            $ch10 = $property->textContent(),;
        }
    }

    # ch11 (IAM11)
    for my $sample ($xmldoc->findnodes('/msg/ch11')) {
        for my $property ($sample->findnodes('./*')) {
            $ch11 = $property->textContent(),;
        }
    }

    # ch12 (IAM12)
    for my $sample ($xmldoc->findnodes('/msg/ch12')) {
        for my $property ($sample->findnodes('./*')) {
            $ch12 = $property->textContent(),;
        }
    }

    # ch13 (IAM13)
    for my $sample ($xmldoc->findnodes('/msg/ch13')) {
        for my $property ($sample->findnodes('./*')) {
            $ch13 = $property->textContent(),;
        }
    }

    # ch14 (IAM14)
    for my $sample ($xmldoc->findnodes('/msg/ch14')) {
        for my $property ($sample->findnodes('./*')) {
            $ch14 = $property->textContent(),;
        }
    }


print "$chH:$ch01:$ch02:$ch03:$ch04:$ch05:$ch06:$ch07:$ch08:$ch09:$ch10:$ch11:$ch12:$ch13:$ch14\n";
system "rrdtool update $RRDFILE N:$chH:$ch01:$ch02:$ch03:$ch04:$ch05:$ch06:$ch07:$ch08:$ch09:$ch10:$ch11:$ch12:$ch13:$ch14";
print "\n";

exit;
}

