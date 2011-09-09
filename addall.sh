#!/bin/sh

if [ -z $1 ]; then
	while read name address location
	do
		echo "Adding $name"
		./addprinter.sh $name $location
	done < printers.conf
else
	grep $1 printers.conf | \
		while read name address location
		do
			echo "Adding $name"
			./addprinter.sh $name $location
		done
fi
