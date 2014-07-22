args append_only



capture mkdir raw_dta
cd "D:\Data/data_NFSPanelAnalysis/OrigData/RAW_79_83"
	


local startdir: pwd // Save current working directory location



local outdata "D:\Data/data_NFSPanelAnalysis/OutData"
local files: dir "." files "*.xls*"



* Create renaming do files dynamically using raw2IBnamemappings.xlsx
*  (Can be made static by turning off if do files already exist)
qui do sub_do/create_renameSheet_code.do



if "`append_only'" != "append_only"{
	*-------------------------------------------------------------
	* 1 Create one dataset per year (i.e. each workbook/.xls file)
	*-------------------------------------------------------------
	foreach spreadsheet of local files{
	
		qui import excel using `spreadsheet', describe
		
		local shortfilename = substr("`spreadsheet'",1,5)
		macro list _shortfilename
	
	
		/* Number of sheets. Store in `N_worksheets' b/c 
		    `r(N_worksheet)' gets erased by the duplicates drop 
	             command in the loop somehow*/
		local N_worksheet = `r(N_worksheet)' 
		capture mkdir raw_dta/`shortfilename'
	
	
	
		*-----------------------------------------------------
		* 1.1 Save each sheet in Stata format, prepare for
		*  merging
		*-----------------------------------------------------
		local i = 12
			di "`i'
			import excel using `spreadsheet'          ///
			       , sheet("Sheet`i'") firstrow clear


			* If a sheet has no obs then it won't save
			*  and you'll get an error. Fix this.
			count
			if `r(N)'==0 {
			   set obs 1
			}	


		        * Drop dups (in terms of all vars) and do 
			*  appropriate algorithm
			qui duplicates drop _all, force
			qui do sub_do/convertSheet`i'.do
		        qui duplicates report farmcode

		        
		        * Note which sheets still have surplus obs
		        if "`r(unique_value)'" != "`r(N)'" {

		            local `i'`shortfilename'_surplus = ///
		               `r(N)' - `r(unique_value)'

		        }	

			
		        * The odd sheet has once-off issues to fix
		      qui do sub_do/specialcases.do `shortfilename' `i'


			sort farmcode
			save raw_dta/`shortfilename'/Sheet`i', replace
			local i = `i' + 1

		}


		*-----------------------------------------------------
		* End of subloop 1.1
		*-----------------------------------------------------
		
}




cd `startdir' // return Stata to previous directory
