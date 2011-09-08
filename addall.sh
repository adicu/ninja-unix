#!/bin/sh

while read name address location
do
	echo "Adding $name"
	./addprinter.sh $name $location
done < printers.conf
