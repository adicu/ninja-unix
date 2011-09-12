#!/bin/sh

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

LPADMIN=`which lpadmin`

if [ -z $LPADMIN ]; then
	echo "Could not find the lpadmin program."
	echo "Either you have not installed CUPS, or lpadmin is not on your PATH"
fi

if [ ! -f printers.conf ]; then
	URL=https://raw.github.com/adicu/ninja-unix/master/printers.conf
	echo "No printers.conf. Attempting to download."
	download $URL	
fi

read_config(){
	while read name address location
	do
		echo "Deleting $name"
		lpadmin -x $name
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
