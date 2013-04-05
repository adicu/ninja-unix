#!/bin/bash

function check_exists {
	which $1 &> /dev/null
}

function download {
	URL=$1
	FILE=`basename $1`
	
	if check_exists wget; then
		wget "$URL"
	elif check_exists curl; then
		curl "$URL" -o "$FILE"
	else
		echo "Please install either wget or curl"
	fi
}

if [ ! -f printers.conf ]; then
	URL=https://raw.github.com/adicu/ninja-unix/master/printers.conf
	echo "No printers.conf. Attempting to download."
	download $URL
fi

PPD="hp-laserjet-9050-$(uname).ppd"

if [ ! -f $PPD ]; then
	URL=https://raw.github.com/adicu/ninja-unix/master/$PPD
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
	$LPADMIN -p $1 -E -v lpd://$2/public -P $PPD -L $3
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
