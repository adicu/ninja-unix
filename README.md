# Ninja-Unix

Add printers from Columbia's ninja print system to your any UNIX/Linux system.

## Directions

First install CUPS, the Common Unix Printing System, and Foomatic, a database 
of common printer drivers. On Mac OS X, Ubuntu, and other "Desktop" Unices, 
this should be installed by default. 

To add a single printer, run `sudo ./addprinter.sh name location`. Here `name` 
is the name of the printer as given by the CUIT website. Location is a 
human-readable description of the location. For example

	sudo ./addprinter.sh butler300a Butler

will add one of the butler printers. To add all the printers, run the command

	sudo ./addall.sh


