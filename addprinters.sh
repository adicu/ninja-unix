#!/bin/sh

if [ ! -f printers.conf ]; then
	URL=https://raw.github.com/adicu/ninja-unix/master/printers.conf
	echo "No printers.conf. Attempting to download."
	if [ -z `which wget` ]; then
		if [ -z `which curl` ]; then
			echo "Please install either wget or curl"
		else
			curl $URL > printers.conf
		fi
	else
		wget $URL
	fi
fi

LPADMIN=`which lpadmin`

if [ -z $LPADMIN ]; then
	echo "Could not find the lpadmin program."
	echo "Either you have not installed CUPS, or lpadmin is not on your PATH"
	exit
fi

FOOMATIC=`which foomatic-ppdfile`

if [ -z $FOOMATIC ]; then
	echo "Could not find foomatic-ppdfile"
	echo "Please install foomatic-db and foomatic-db-engine before continuing."
	exit
fi

DRIVER="foomatic:HP-LaserJet_9050-Postscript.ppd"

add_ninja(){
	$LPADMIN -p $1 -E -v lpd://$2/public -m $DRIVER -L $3
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
