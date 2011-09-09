# Ninja-Unix

Add printers from Columbia's ninja print system to any UNIX/Linux system.

## Directions

First install CUPS, the Common Unix Printing System. On Mac OS X, Ubuntu, and 
other "User-Friendly" Unices, this should be installed by default. This package
is generally named "cups" in most distribution package repositories. If you
install CUPS manually, make sure the cups daemon is started and running.

Install the Foomatic database and database engine. Foomatic is a database 
containing information about many common printer models. These packages may 
also be installed by default for your distribution. The foomatic database and 
database engine packages are commonly named "foomatic-db" and 
"foomatic-db-engine" respectively.

To add a single printer, run `sudo ./addprinter.sh name location`. Here `name`
is the name of the printer as given by the CUIT website. Location is a
human-readable description of the location. For example

	sudo ./addprinter.sh butler300a Butler

will add one of the butler printers. To add all the printers, run the command

	sudo ./addall.sh

This will most likely take a long time. For convenience, you may supply an 
argument to addall.sh to only add printers in a certain location. For instance

	sudo ./addall.sh butler

will add only the printers in Butler Library.

