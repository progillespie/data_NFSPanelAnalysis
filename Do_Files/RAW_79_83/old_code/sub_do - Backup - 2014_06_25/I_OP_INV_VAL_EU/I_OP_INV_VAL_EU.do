* Create whatever derived variables are needed for this variable and 
*  calculate the variable itself.


local startdir: pwd // Save current working directory location


* Move into the root of the variable's directory
local this_file_calculates "I_OP_INV_VAL_EU"
qui cd  `this_file_calculates'
local vardir: pwd 



* Needed variables get their own subdirectories. Look for subfolders
*  and use their names to determine which variables you need to 
*  calculate for this variable.
local vars_needed: dir "." dirs * 


foreach var_needed of local vars_needed {
	di "Deriving `var_needed'"
	qui do `var_needed'/`var_needed'.do
}




* Create a list of variables which may not exist for the early years
local nonexist_vlist "`nonexist_vlist' "



* Add nonexist variables to global list of zero vars
global zero_vlist "$zero_vlist `nonexist_vlist'"

* Make sure each variable enters list only once
global zero_vlist: list uniq global(zero_vlist)



* Check if those vars exist, and if not create them as zero vectors
foreach var of local nonexist_vlist {

	capture confirm variable `var'

	if _rc!=0{
	
		if "`var'"== "OTHER_SUBS_TOTAL_EU"{
		   gen OTHER_SUBS_TOTAL_EU = 0
		}
	
		else {
		   gen `var' = 0
		}

	}

}

* Get list of relevant crop codes
qui ds OP_INV_QTY_TONNES_HA9??0
local vlist "`r(varlist)'"




foreach var of local vlist {
        
    * Extract code from the varname
    local code = substr("`var'", -4, .)
    local crop_codes "`crop_codes' `code'"

    * And just the first 3 digits too
    local first3 = substr("`code'",1,3)


    * Ensure no missing in all except CY_TOTAL_YIELD
        
    local var "OP_INV_QTY_TONNES_HA`code'" 
    replace `var' = 0 if missing(`var')

    local var "OP_INV_VALUE_EU`code'" 
    replace `var' = 0 if missing(`var')

    local var "D_TOTAL_DIRECT_COST_EU`first3'1" 
    replace `var' = 0 if missing(`var')



    * Initialise var at 0
    capture drop `this_file_calculates'`code'
    gen double `this_file_calculates'`code' =  0



    replace `this_file_calculates'`code' =    ///
      (OP_INV_QTY_TONNES_HA`code' /             ///
       CY_TOTAL_YIELD`first3'1    )*            ///
       D_TOTAL_DIRECT_COST_EU`first3'1          ///
                                             ///
                                             ///
        if  [OP_INV_QTY_TONNES_HA`code' > 0   & ///
             OP_INV_VALUE_EU`code'     == 0]  & ///
           !missing(CY_TOTAL_YIELD`first3'1)  & ///
           CY_TOTAL_YIELD`first3'1    > 0



    replace `this_file_calculates'`code' =   ///
      OP_INV_VALUE_EU`code'                     ///
                                             ///
                                             ///
        if ![OP_INV_QTY_TONNES_HA`code' > 0   & ///
             OP_INV_VALUE_EU`code'     == 0]  & ///
           missing(CY_TOTAL_YIELD`first3'1)



    replace `this_file_calculates'`code' =   ///
      OP_INV_QTY_TONNES_HA`code' * 55           ///
                                             ///
                                             ///
        if  [OP_INV_QTY_TONNES_HA`code' > 0   & ///
             OP_INV_VALUE_EU`code'     == 0]  & ///
           missing(CY_TOTAL_YIELD`first3'1)   & ///
            ["`code'"=="9020"|"`code'"=="9030" ]



    replace `this_file_calculates'`code' =   ///
      OP_INV_QTY_TONNES_HA`code' * 40           ///
                                             ///
                                             ///
        if  [OP_INV_QTY_TONNES_HA`code' > 0   & ///
             OP_INV_VALUE_EU`code'     == 0]  & ///
           missing(CY_TOTAL_YIELD`first3'1)   & ///
            ["`code'"=="9040"|"`code'"=="9050"| ///
             "`code'"=="9060"|"`code'"=="9070"| ///
             "`code'"=="9080"|"`code'"=="9090" ]



    replace `this_file_calculates'`code' =   ///
      OP_INV_QTY_TONNES_HA`code' * 25           ///
                                             ///
                                             ///
        if  [OP_INV_QTY_TONNES_HA`code' > 0   & ///
             OP_INV_VALUE_EU`code'     == 0]  & ///
           missing(CY_TOTAL_YIELD`first3'1)   & ///
           !["`code'"=="9020"|"`code'"=="9030"| ///
             "`code'"=="9040"|"`code'"=="9050"| ///
             "`code'"=="9060"|"`code'"=="9070"| ///
             "`code'"=="9080"|"`code'"=="9090" ]

}






* Add required variables to global list of required vars
global required_vars "$required_vars `vlist'"

* Make sure each variable enters list only once
global required_vars: list uniq global(required_vars)



cd `startdir' // return Stata to previous directory
ds `this_file_calculates'*, varwidth(32)
