* Realised that I have D_SAMPLE_CELL for all years in the data!
*  This file uses that info to assign a system variable and weights
*  implied by the cell counts for the only year in which it is
*  possible (1993, because prior to that different system definitions
*  were used). D_FARM_GROSS_OUTPUT is now MUCH closer to the book 
*  value.  
use "D:\\Data\\data_NFSPanelAnalysis\\OrigData\\nfs_all\\dataallyears_out1", clear

gen int testsys = .
replace testsys =1 if D_SAMPLE_CELL                       <  7 & D_SOIL_GROUP < 3
replace testsys =2 if D_SAMPLE_CELL >= 7  & D_SAMPLE_CELL < 13 & D_SOIL_GROUP < 3
replace testsys =4 if D_SAMPLE_CELL >= 19 & D_SAMPLE_CELL < 25 & D_SOIL_GROUP < 3
replace testsys =5 if D_SAMPLE_CELL >= 25 & D_SAMPLE_CELL < 31 & D_SOIL_GROUP < 3
replace testsys =6 if D_SAMPLE_CELL >= 31 & D_SAMPLE_CELL < 37 & D_SOIL_GROUP < 3
replace testsys =7 if D_SAMPLE_CELL >= 37 & D_SAMPLE_CELL < 43 & D_SOIL_GROUP < 3

replace UAA_WEIGHT= 148  if year==1993 & D_SAMPLE_CELL == 1
replace UAA_WEIGHT= 135  if year==1993 & D_SAMPLE_CELL == 2
replace UAA_WEIGHT= 115  if year==1993 & D_SAMPLE_CELL == 3
replace UAA_WEIGHT= 86   if year==1993 & D_SAMPLE_CELL == 4
replace UAA_WEIGHT= 59   if year==1993 & D_SAMPLE_CELL == 5
replace UAA_WEIGHT= 17   if year==1993 & D_SAMPLE_CELL == 6
replace UAA_WEIGHT= 1156 if year==1993 & D_SAMPLE_CELL == 7
replace UAA_WEIGHT= 297  if year==1993 & D_SAMPLE_CELL == 8
replace UAA_WEIGHT= 113  if year==1993 & D_SAMPLE_CELL == 9
replace UAA_WEIGHT= 91   if year==1993 & D_SAMPLE_CELL == 10
replace UAA_WEIGHT= 47   if year==1993 & D_SAMPLE_CELL == 11
replace UAA_WEIGHT= 32   if year==1993 & D_SAMPLE_CELL == 12
replace UAA_WEIGHT= 216  if year==1993 & D_SAMPLE_CELL == 13
replace UAA_WEIGHT= 216  if year==1993 & D_SAMPLE_CELL == 19
replace UAA_WEIGHT= 151  if year==1993 & D_SAMPLE_CELL == 20
replace UAA_WEIGHT= 135  if year==1993 & D_SAMPLE_CELL == 21
replace UAA_WEIGHT= 64   if year==1993 & D_SAMPLE_CELL == 22
replace UAA_WEIGHT= 39   if year==1993 & D_SAMPLE_CELL == 23
replace UAA_WEIGHT= 0    if year==1993 & D_SAMPLE_CELL == 24
replace UAA_WEIGHT= 149  if year==1993 & D_SAMPLE_CELL == 25
replace UAA_WEIGHT= 286  if year==1993 & D_SAMPLE_CELL == 26
replace UAA_WEIGHT= 168  if year==1993 & D_SAMPLE_CELL == 27
replace UAA_WEIGHT= 158  if year==1993 & D_SAMPLE_CELL == 28
replace UAA_WEIGHT= 221  if year==1993 & D_SAMPLE_CELL == 29
replace UAA_WEIGHT= 43   if year==1993 & D_SAMPLE_CELL == 30
replace UAA_WEIGHT= 91   if year==1993 & D_SAMPLE_CELL == 31
replace UAA_WEIGHT= 172  if year==1993 & D_SAMPLE_CELL == 32
replace UAA_WEIGHT= 70   if year==1993 & D_SAMPLE_CELL == 33
replace UAA_WEIGHT= 79   if year==1993 & D_SAMPLE_CELL == 34
replace UAA_WEIGHT= 118  if year==1993 & D_SAMPLE_CELL == 35
replace UAA_WEIGHT= 68   if year==1993 & D_SAMPLE_CELL == 36
replace UAA_WEIGHT= 180  if year==1993 & D_SAMPLE_CELL == 37
replace UAA_WEIGHT= 75   if year==1993 & D_SAMPLE_CELL == 38
replace UAA_WEIGHT= 90   if year==1993 & D_SAMPLE_CELL == 39
replace UAA_WEIGHT= 76   if year==1993 & D_SAMPLE_CELL == 40
replace UAA_WEIGHT= 61   if year==1993 & D_SAMPLE_CELL == 41
replace UAA_WEIGHT= 30   if year==1993 & D_SAMPLE_CELL == 42

* Change weights for hill farms
replace UAA_WEIGHT= 53   if D_SAMPLE_CELL                        < 7 & D_SOIL_GROUP == 3 
replace UAA_WEIGHT= 315  if D_SAMPLE_CELL >=  7 & D_SAMPLE_CELL < 13 & D_SOIL_GROUP == 3
replace UAA_WEIGHT= 123  if D_SAMPLE_CELL >= 19 & D_SAMPLE_CELL < 25 & D_SOIL_GROUP == 3 
replace UAA_WEIGHT= 164  if D_SAMPLE_CELL >= 25 & D_SAMPLE_CELL < 31 & D_SOIL_GROUP == 3
replace UAA_WEIGHT= 78   if D_SAMPLE_CELL >= 31 & D_SAMPLE_CELL < 37 & D_SOIL_GROUP == 3
replace UAA_WEIGHT= 0    if D_SAMPLE_CELL >= 37 & D_SAMPLE_CELL < 43 & D_SOIL_GROUP == 3
