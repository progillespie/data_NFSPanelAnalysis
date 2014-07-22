cd "D:\Data\data_NFSPanelAnalysis\OrigData\RAW_79_83\"

import excel using "D:\Data\data_NFSPanelAnalysis\Support_Docs\raw2SASnamemapping/raw2IBnamemappings.xlsx", firstrow sheet("AllVarsMapping") allstring clear

drop if DefaultStatavarname==":"


local i = 1
while `i' < 71{

	di "Generating renaming code for Sheet `i'"
	outfile rename DefaultStatavarname Mappedcode ///
	   using sub_do/renameSheet`i'.do ///
	   if Sheet == "Sheet `i'"  ///
	   , noq wide replace
	local i = `i' + 1

}




local i = 1
while `i' < 2{
	di "Doing convertSheet`i'.do ..."
	qui do sub_do/convertSheet`i'.do standalone
	di "convertSheet`i'.do completed without error."

	local i = `i' + 1
}


