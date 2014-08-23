*******************************************
* Create sample cell membership variable
*******************************************


* Define column criterion (common to modern and historic tables)
local col1 "UAA_SIZE <   10 "
local col2 "UAA_SIZE >=  10 & UAA_SIZE <  20" 
local col3 "UAA_SIZE >=  20 & UAA_SIZE <  30" 
local col4 "UAA_SIZE >=  30 & UAA_SIZE <  50" 
local col5 "UAA_SIZE >=  50 & UAA_SIZE < 100" 
local col6 "UAA_SIZE >= 100" 


* Use these to define a variable for tables later
capture drop tableBcol
gen int tableBcol = . 
replace tableBcol = 1 if `col1'
replace tableBcol = 2 if `col2'
replace tableBcol = 3 if `col3'
replace tableBcol = 4 if `col4'
replace tableBcol = 5 if `col5'
replace tableBcol = 6 if `col6'


* Label this variable and its values for tables later
label define tableBcol 1 "< 10", modify
label define tableBcol 2 "10 - 20", modify
label define tableBcol 3 "20 - 30", modify
label define tableBcol 4 "30 - 50", modify
label define tableBcol 5 "50 - 100", modify
label define tableBcol 6 ">100", modify

label values tableBcol tableBcol 
label var tableBcol "Farm size categories (UAA)."






*--------------------------------------------------------------------
* Modern cell designations
*--------------------------------------------------------------------

* Define modern row criterion (note there is no system 3)
local row1 "FARM_SYSTEM == 1"
local row2 "FARM_SYSTEM == 2"
local row3 "FARM_SYSTEM == 4"
local row4 "FARM_SYSTEM == 5"
local row5 "FARM_SYSTEM == 6"
local row6 "FARM_SYSTEM == 7"



* Assign modern cell designations based on row and column criterion
*  (note that cell index numbers 
capture drop D_SAMPLE_CELL
gen int D_SAMPLE_CELL = .
replace D_SAMPLE_CELL =  1 if `row1' & `col1'
replace D_SAMPLE_CELL =  2 if `row1' & `col2'
replace D_SAMPLE_CELL =  3 if `row1' & `col3'
replace D_SAMPLE_CELL =  4 if `row1' & `col4'
replace D_SAMPLE_CELL =  5 if `row1' & `col5'
replace D_SAMPLE_CELL =  6 if `row1' & `col6'

replace D_SAMPLE_CELL =  7 if `row2' & `col1'
replace D_SAMPLE_CELL =  8 if `row2' & `col2'
replace D_SAMPLE_CELL =  9 if `row2' & `col3'
replace D_SAMPLE_CELL = 10 if `row2' & `col4'
replace D_SAMPLE_CELL = 11 if `row2' & `col5'
replace D_SAMPLE_CELL = 12 if `row2' & `col6'

replace D_SAMPLE_CELL = 19 if `row3' & `col1'
replace D_SAMPLE_CELL = 20 if `row3' & `col2'
replace D_SAMPLE_CELL = 21 if `row3' & `col3'
replace D_SAMPLE_CELL = 22 if `row3' & `col4'
replace D_SAMPLE_CELL = 23 if `row3' & `col5'
replace D_SAMPLE_CELL = 24 if `row3' & `col6'

replace D_SAMPLE_CELL = 25 if `row4' & `col1'
replace D_SAMPLE_CELL = 26 if `row4' & `col2'
replace D_SAMPLE_CELL = 27 if `row4' & `col3'
replace D_SAMPLE_CELL = 28 if `row4' & `col4'
replace D_SAMPLE_CELL = 29 if `row4' & `col5'
replace D_SAMPLE_CELL = 30 if `row4' & `col6'

replace D_SAMPLE_CELL = 31 if `row5' & `col1'
replace D_SAMPLE_CELL = 32 if `row5' & `col2'
replace D_SAMPLE_CELL = 33 if `row5' & `col3'
replace D_SAMPLE_CELL = 34 if `row5' & `col4'
replace D_SAMPLE_CELL = 35 if `row5' & `col5'
replace D_SAMPLE_CELL = 36 if `row5' & `col6'

replace D_SAMPLE_CELL = 37 if `row6' & `col1'
replace D_SAMPLE_CELL = 38 if `row6' & `col2'
replace D_SAMPLE_CELL = 39 if `row6' & `col3'
replace D_SAMPLE_CELL = 40 if `row6' & `col4'
replace D_SAMPLE_CELL = 41 if `row6' & `col5'
replace D_SAMPLE_CELL = 42 if `row6' & `col6'

* Remove hill farms' cell designation
replace D_SAMPLE_CELL = . if D_SOIL_GROUP==3

*--------------------------------------------------------------------






*--------------------------------------------------------------------
* Historic cell designations
*--------------------------------------------------------------------

* Define historic row criterion
local row1 "FARM_SYSTEM_HISTORIC == 1"
local row2 "FARM_SYSTEM_HISTORIC == 2"
local row3 "FARM_SYSTEM_HISTORIC == 3"
local row4 "FARM_SYSTEM_HISTORIC == 4"
local row5 "FARM_SYSTEM_HISTORIC == 5"
local row6 "FARM_SYSTEM_HISTORIC == 6"
local row7 "FARM_SYSTEM_HISTORIC == 7"
local row8 "FARM_SYSTEM_HISTORIC == 8"


* Assign historic cell designations based on row and column criterion
capture drop D_SAMPLE_CELL_HISTORIC
gen int D_SAMPLE_CELL_HISTORIC = .
replace D_SAMPLE_CELL_HISTORIC =  1 if `row1' & `col1'
replace D_SAMPLE_CELL_HISTORIC =  2 if `row1' & `col2'
replace D_SAMPLE_CELL_HISTORIC =  3 if `row1' & `col3'
replace D_SAMPLE_CELL_HISTORIC =  4 if `row1' & `col4'
replace D_SAMPLE_CELL_HISTORIC =  5 if `row1' & `col5'
replace D_SAMPLE_CELL_HISTORIC =  6 if `row1' & `col6'

replace D_SAMPLE_CELL_HISTORIC =  7 if `row2' & `col1'
replace D_SAMPLE_CELL_HISTORIC =  8 if `row2' & `col2'
replace D_SAMPLE_CELL_HISTORIC =  9 if `row2' & `col3'
replace D_SAMPLE_CELL_HISTORIC = 10 if `row2' & `col4'
replace D_SAMPLE_CELL_HISTORIC = 11 if `row2' & `col5'
replace D_SAMPLE_CELL_HISTORIC = 12 if `row2' & `col6'

replace D_SAMPLE_CELL_HISTORIC = 13 if `row3' & `col1'
replace D_SAMPLE_CELL_HISTORIC = 14 if `row3' & `col2'
replace D_SAMPLE_CELL_HISTORIC = 15 if `row3' & `col3'
replace D_SAMPLE_CELL_HISTORIC = 16 if `row3' & `col4'
replace D_SAMPLE_CELL_HISTORIC = 17 if `row3' & `col5'
replace D_SAMPLE_CELL_HISTORIC = 18 if `row3' & `col6'

replace D_SAMPLE_CELL_HISTORIC = 19 if `row4' & `col1'
replace D_SAMPLE_CELL_HISTORIC = 20 if `row4' & `col2'
replace D_SAMPLE_CELL_HISTORIC = 21 if `row4' & `col3'
replace D_SAMPLE_CELL_HISTORIC = 22 if `row4' & `col4'
replace D_SAMPLE_CELL_HISTORIC = 23 if `row4' & `col5'
replace D_SAMPLE_CELL_HISTORIC = 24 if `row4' & `col6'

replace D_SAMPLE_CELL_HISTORIC = 25 if `row5' & `col1'
replace D_SAMPLE_CELL_HISTORIC = 26 if `row5' & `col2'
replace D_SAMPLE_CELL_HISTORIC = 27 if `row5' & `col3'
replace D_SAMPLE_CELL_HISTORIC = 28 if `row5' & `col4'
replace D_SAMPLE_CELL_HISTORIC = 29 if `row5' & `col5'
replace D_SAMPLE_CELL_HISTORIC = 30 if `row5' & `col6'

replace D_SAMPLE_CELL_HISTORIC = 31 if `row6' & `col1'
replace D_SAMPLE_CELL_HISTORIC = 32 if `row6' & `col2'
replace D_SAMPLE_CELL_HISTORIC = 33 if `row6' & `col3'
replace D_SAMPLE_CELL_HISTORIC = 34 if `row6' & `col4'
replace D_SAMPLE_CELL_HISTORIC = 35 if `row6' & `col5'
replace D_SAMPLE_CELL_HISTORIC = 36 if `row6' & `col6'

replace D_SAMPLE_CELL_HISTORIC = 37 if `row7' & `col1'
replace D_SAMPLE_CELL_HISTORIC = 38 if `row7' & `col2'
replace D_SAMPLE_CELL_HISTORIC = 39 if `row7' & `col3'
replace D_SAMPLE_CELL_HISTORIC = 40 if `row7' & `col4'
replace D_SAMPLE_CELL_HISTORIC = 41 if `row7' & `col5'
replace D_SAMPLE_CELL_HISTORIC = 42 if `row7' & `col6'

replace D_SAMPLE_CELL_HISTORIC = 43 if `row8' & `col1'
replace D_SAMPLE_CELL_HISTORIC = 44 if `row8' & `col2'
replace D_SAMPLE_CELL_HISTORIC = 45 if `row8' & `col3'
replace D_SAMPLE_CELL_HISTORIC = 46 if `row8' & `col4'
replace D_SAMPLE_CELL_HISTORIC = 47 if `row8' & `col5'
replace D_SAMPLE_CELL_HISTORIC = 48 if `row8' & `col6'

* Remove hill farms' cell designation
replace D_SAMPLE_CELL_HISTORIC = . if D_SOIL_GROUP==3
