#!/usr/bin/env python
#Moses Nakamura
import re
import urllib


#all of the js files that have the information we need
links=["http://www.columbia.edu/acis/facilities/printers/ninja/acis/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/barnard/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/cait/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/lso/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/meche/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/old_pcd/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/soa/js/printers.js","http://www.columbia.edu/acis/facilities/printers/ninja/ssw/js/printers.js"]

searcher = re.compile(r"\[([^\]]*)\];")
lst=[]

#scrapes the files, puts the information into lists in lists
for link in links:
    filep = urllib.urlopen(link)
    for line in filep:
        matched = searcher.search(line)
        if matched:
            #note: the strings are surrounded by the character ", 
            #which is actually pretty useful.  Don't need to change this.
            lst.append(matched.group(1).split(","))



#organizes the information nicely
towrite = []

for line in lst:
    towrite.append(line[0] + " " + line[1] + " " + line[3] + "\n")

#writes it into the correct format in newprinter.yaml file
filep = open("newprinters.conf","w")
filep.writelines(towrite)



