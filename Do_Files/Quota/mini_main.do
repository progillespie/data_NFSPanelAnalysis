args outdatadir
use `outdatadir'/data_for_dairydofile, clear


*qui do create_renameIB2SAS_code.do // to update renaming file
do sub_do/renameIB2SAS.do       // to run renaming file
*do sub_do/indices.do            // farm level price indices (not used yet)
do sub_do/dairydofile.do "`outdatadir'"      // prep for NLogit

* % early calving
egen ecalf = rowtotal(dpcfbjan dpcfbfeb  dpcfbmar)
gen ecalfpct = ecalf/dpcfbtot




* Note the difference in sample composition < 1984
tab SZCLASS year, column nofreq


* Draw and save box plots to show differences in sample
qui do sub_do/yrbox  // program for box plots w/ hard-coded options 
*qui do sub_do/plots `outdatadir'  // actual box plot commands


* Change to SAS varnames
*qui do sub_do/renameIB2SAS.do

* ------------------------------------------------------------------
