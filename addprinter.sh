#!/bin/sh

LPADMIN=`which lpadmin`

$LPADMIN -p $1 -E -v lpd://$1-ninja.atg.columbia.edu/public \
	-m foomatic:HP-LaserJet_9050-Postscript.ppd -L $2

