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

To add all the printers, run the command

	sudo ./addprinters.sh

This will most likely take a long time. If you want to add a specific printer
supply an argument to the program. For instance

	sudo ./addprinters.sh butler

will add only the printers in butler library, whereas

	sudo ./addprinters.sh butler301a

will add a specific printer in butler.
