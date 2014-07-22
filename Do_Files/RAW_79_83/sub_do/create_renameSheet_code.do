* Reads Excel spreadsheet to create code for naming raw variables.
*  from default varnames (after importing from excel to Stata) 
*  to IB style. 

* DOES NOT do the renaming itself... it writes the code file which
*  does that. 

* There will be a separate renaming file for each Sheet
*  of the raw data spreadsheet, and this will be called by the 
*  convertSheet file (also specific to each sheet of the 
*  spreadsheet).


import excel using "D:\Data\data_NFSPanelAnalysis\Support_Docs\raw2SASnamemapping\raw2IBnamemappings.xlsx", firstrow sheet("AllVarsMapping") allstring clear



drop if DefaultStatavarname==":"



local i = 1
while `i' < 71{

	di "Generating renaming code for Sheet `i'"

	* Stata thinks the code is a dataset, so write 
        *  a do file which Stata will read back in later.

        *  By selecting the variables "rename" "Default.."
        *  etc. we've isolated the columns with code in them
        *  and the "if Sheet ==" part gets just the renaming
        *  commands that are relevant for a particular sheet.

	outfile rename DefaultStatavarname Mappedcode ///
	   using sub_do/_renameSheet/renameSheet`i'.do ///
	   if Sheet == "Sheet `i'"  ///
	   , noq wide replace

	local i = `i' + 1

}
