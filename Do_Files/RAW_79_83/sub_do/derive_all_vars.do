* Quick do-file to instruct Stata to do all do-files which define
*  a NFS derived variable. Assumes the variable definitions are in 
*  dodir, and that you have a dataset with the required raw variables
*  loaded in memory (e.g. nfs_7983.dta)


* record the startdir, so we can return to it when finished
local startdir: pwd


* define dodir local (i.e. the folder with the variable definitions)
local dodir "D:\Data\data_NFSPanelAnalysis\Do_Files\RAW_79_83\sub_do"
cd `dodir'


* Gives you a local with the names of all folders beginning with 
*  D_. This should be all available variable definitions, and only
*  variable definitions. 
local derived_vars: dir "." dir "D_*", respectcase


log using derive_all_vars.log

* Loop to call each do_file (will be same name as folder, and located
*  within each folder)
foreach var of local derived_vars{
    di "Deriving `var'..."
    qui do `var'/`var'

}

log close
cd `startdir' // return Stata to starting directory
