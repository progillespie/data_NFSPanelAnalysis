* Calls the do files which create derived variables. 
*  If a variable requires that other derived vars be calculated then 
*   this will be done automatically.

local startdir: pwd // Save current working directory location
cd sub_do



* Build a list of vars to calculate. Copy and paste a new line for
*  each var. Works for high level vars only (i.e. those whose folder
*  is located in sub_do. 

local vars_to_calculate "`vars_to_calculate' D_FARM_GROSS_OUTPUT"
*local vars_to_calculate "`vars_to_calculate' INSERT_VARNAME_HERE" 



foreach var of local vars_to_calculate {

	do `var'/`var'.do

}



* ======================================================================
* Low level variables (once-off calculations)
* ======================================================================
* NOTE: Many derived vars will be subfolders of one of the high level 
*        vars. These will be calculated as needed, but if you want to 
*        get just a particular low level var that hasn't been required
*        created, you can do this with the following: 



*cd "FULL_PATH_TO_VARIABLE's_DO_FILE/.."
*do VARIABLE_TO_CALCULATE/VARIABLE_TO_CALCULATE.do



* The "/.." in the cd command takes you to the folder ONE LEVEL ABOVE 
*  the one containing the appropriate do file. This is where Stata
*  needs to be in order for that do file to run correctly. 
*
* Copy, paste, and edit the cd and do commands for each variable you 
*  create in this way (i.e. as a once-off). 
*
* This must be done AFTER all high level variables are calculated 
*  (other wise that code might try to create the same variable again, 
*  which would be an error). It's also tidier if you keep the new lines 
*  within this section anyway.
* ======================================================================


cd `startdir' // return Stata to the working directory we started from
