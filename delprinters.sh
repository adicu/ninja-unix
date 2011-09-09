#!/bin/sh

LPADMIN=`which lpadmin`

if [ -z $LPADMIN ]; then
	echo "Could not find the lpadmin program."
	echo "Either you have not installed CUPS, or lpadmin is not on your PATH"
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
