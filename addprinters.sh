#!/bin/bash

function download {
	URL=$1
	FILE=`basename $1`
	if [ -z `which wget` ]; then
		if [ -z `which curl` ]; then
			echo "Please install either wget or curl"
		else
			curl $URL > $FILE 
		fi
	else
		wget $URL
	fi
}

if [ ! -f printers.conf ]; then
	URL=https://raw.github.com/adicu/ninja-unix/master/printers.conf
	echo "No printers.conf. Attempting to download."
	download $URL	
fi

if [ ! -f hp-laserjet-9050.ppd ]; then
	URL=https://raw.github.com/adicu/ninja-unix/master/hp-laserjet-9050.ppd
	echo "No ppd file. Attempting to download."
	download $URL
fi

LPADMIN=`which lpadmin`

if [ -z $LPADMIN ]; then
	echo "Could not find the lpadmin program."
	echo "Either you have not installed CUPS, or lpadmin is not on your PATH"
	exit
fi

add_ninja(){
	OS=`uname`
	if [ $OS == 'Linux' ]; then
		DRIVER="-m foomatic:HP-LaserJet_9050-Postscript.ppd"
	else
		if [ $OS == 'Darwin' ]; then
			DRIVER="-P hp-laserjet-9050.ppd"
		fi
	fi
	$LPADMIN -p $1 -E -v lpd://$2/public $DRIVER -L $3
}

read_config(){
	while read name address location
	do
		echo "Adding $name"
		add_ninja $name $address $location
	done
}

if [ -z $1 ]; then
	read_config < printers.conf
else
	exists=`grep $1 printers.conf | head -n 1`
	if [ -z "$exists" ]; then
		echo "Could not find printer matching this pattern"
		exit
	fi
	grep $1 printers.conf | read_config
fi
