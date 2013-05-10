# Ninja-Unix

Add printers from Columbia's ninja print system to any UNIX/Linux system.

## Directions

First install CUPS, the Common Unix Printing System. On Mac OS X, Ubuntu, and 
other "User-Friendly" Unices, this should be installed by default. This package
is generally named "cups" in most distribution package repositories. If you
install CUPS manually, make sure the cups daemon is started and running.

To add all the printers, run the command

	sudo ./addprinters.sh

This will most likely take a long time. If you want to add a specific printer
supply an argument to the program. For instance

	sudo ./addprinters.sh butler

will add only the printers in butler library, whereas

	sudo ./addprinters.sh butler301a

will add a specific printer in butler.

There is also a delprinters.sh script which is used in the same way, but 
deletes printers instead of adding them. 

## Mac Executables

[Add and delete printer apps located here.](https://www.dropbox.com/s/t2s0thy1yvryvaq/ColumbiaPrinters.zip)

## Missing Printers

If you think any printers are missing, run the scraper script to add all available ninja printers

    python scraper.py

This will update the printers.conf file that the add printers script uses.
