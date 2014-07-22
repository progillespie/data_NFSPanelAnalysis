** Working out how to add years of data using James Carroll's Data Creator.
** Dataset available to me is cod_data_84_to_09.xls
** Had some problem with that format, so saved as a CSV named x_data_84_to_09.csv
clear
set mem 500m
cd "D:\Documents and Settings\p.gillespie\wfpack\Productivity Research"

insheet using "Stata Datasets\data8409\x_data_84_to_09.csv"

** Data creator seems to add one year at a time, so drop all but 1995 (see next command) and set t = 0 in DAIRY data creator.do (not shown here)

keep if year == 1995

** try running the do file for dairy... 

*do "Data creator (Stata Do)\DAIRY data creator.do"

** Uncommenting the previous line will show that ffszsyst is missing from x_data_84_to_09.csv. One would guess that this corresponds to farmsys variable that IS in this dataset. Sent variables for system and farmcode from x_data_84_to_09.csv and James' 96-06 data (1996 in former = t=1 in latter) to a separate worksheet for comparison. They match up once you drop missing data from this dataset, and sys code 8 from James' (not sure what that is) In any case it doesn't matter, as DAIRY data creator.do will keep only sys code 1 (specialist dairy). Therefore, I've conlcuded that farmsys is the same as ffszsyst and can be substituted in James' rename command at the top of DAIRY data creator.do for all years from this dataset once missing data is dropped.

drop if farmsys>=.

** Don't forget to change ffszsyst to farmsys at the top of Dairy data creator.do!
** same problem with ffarmcod... almost certainly corresponds to  cffrmcod

do "Data creator (Stata Do)\DAIRY data creator.do"



