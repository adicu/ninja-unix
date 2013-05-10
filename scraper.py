#!/usr/bin/env python
#Moses Nakamura & Nate Brennand
import urllib


#all of the js files that have the information we need
links=["http://www.columbia.edu/acis/facilities/printers/ninja/acis/js/printers.js",
    "http://www.columbia.edu/acis/facilities/printers/ninja/barnard/js/printers.js",
    "http://www.columbia.edu/acis/facilities/printers/ninja/cait/js/printers.js",
    "http://www.columbia.edu/acis/facilities/printers/ninja/lso/js/printers.js",
    "http://www.columbia.edu/acis/facilities/printers/ninja/meche/js/printers.js",
    "http://www.columbia.edu/acis/facilities/printers/ninja/old_pcd/js/printers.js",
    "http://www.columbia.edu/acis/facilities/printers/ninja/soa/js/printers.js",
    "http://www.columbia.edu/acis/facilities/printers/ninja/ssw/js/printers.js"]

lst=[]
#scrapes the files, puts the information into lists in lists
for link in links:
    filep = urllib.urlopen(link)
    for line in filep:
        if line.count('[') == 2:
            line = line.replace('"', '') # removing double quotations from strings
            line = line[line.rfind('[')+1 : line.rfind(']')-1]
            lst.append(line.split(","))

#organizes the information nicely
towrite = []

for line in sorted(lst):
    towrite.append("{} {} {}\n".format(line[0], line[1], line[3]))

#writes it into the correct format in newprinter.yaml file
filep = open("printers.conf","w")
filep.writelines(towrite)

