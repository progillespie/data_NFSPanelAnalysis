********************************************************
********************************************************
*       Cathal O'Donoghue, REDP Teagasc
*       &
*       Patrick R. Gillespie                            
*       Walsh Fellow                    
*       Teagasc, REDP                           
*       patrick.gillespie@teagasc.ie            
********************************************************
* Farm Level Microsimulation Model
*       Cross country SFA analysis
*       Using FADN Panel Data                         
*       
*       Code for PhD Thesis chapter
*       Contribution to Multisward 
*       Framework Project
*                                                    
*       Thesis Supervisors:
*       Cathal O'Donoghue
*       Stephen Hynes
*       Thia Hennessey
*       Fiona Thorne
*
********************************************************
* READ THE README.txt FILE BEFORE CHANGING ANYTHING!!!
********************************************************
* First edited 27th June, 2013

* Tasks
*    - remove teagasc from varlist (the FADN variable 
*       doesn't really map well...)                       
*                                                [done]   
*
*    - replace corr of data1.dta  with one for  to 
*       reply to redundancy critique
*                                                [done]   
*
*    - provide stats on the correlation of Environmental
*       subsidies with farm size 
*                                                [done]   
*
*    - moved dataname definition to the top of the file
*                                                [done]   
*
*    - use $dataname in log commands
*                                                [done]   
*
*    - move dependent var out of the varlist, 
*       name indep_vlist
*                                                [done]   
*
*    - create dependent var macro, name dep_vlist 
*                                                [done]   
*
*    - create country and region var macro, 
*       name location_vlist
*                                                [done]   
*
*    - adjust model commands to reflect new macros 
*       using `indep_vlist' in eff. effects 
*                                                [done]   
*


version 9.0
clear
clear matrix
set mem 700m
set matsize 2500
set more off
capture log close
capture cmdlog close








********************************************************
********************************************************
* Run Parameters
********************************************************
********************************************************



******************************************
* Run from raw FADN data?
* "" (i.e. an empty string) for YES
* "*" for NO
******************************************
local build = "*"

* Name the new panel of data you're creating
* best to make it match the name of this do file
global dataname "msward_2013_06_27"


*** Define model variables
* Give the varnames of the dependent and the explanatory vars
local dep_vlist "lndotomkgl " 
local indep_vlist "lnfsizuaa lndaforare lnflabpaid lnflabunpd lndpnolu azone2 azone3 hasreps ogagehld" // <- need a grass variable
local location_vlist "France Ireland UK Bretagne NormandieHaute NormandieBasse Wales Bayern" // <- may have to rethink region dummies



********************************************************
* Directories
********************************************************
* global datadir to be passed to sub_do files
global datadir G:\Data
*global datadir /media/MyPassport/Data
*global datadir C:\Users\03113752\Data

* these local definitions to be copied to sub_do files
*local datadir /media/MyPassport/Data
local datadir $datadir
local fadnpaneldir `datadir'/data_FADNPanelAnalysis
local nfspaneldir `datadir'/data_NFSPanelAnalysis





* Original Data
*--------------------------------------------
* filepaths of subdirectories of fadnpaneldir
*   origdatadir is deliberately NOT called
*   fadnorigdatadir (ensures that NFS data
*   isn't called anywhere in the files)
local origdatadir `fadnpaneldir'/OrigData 
local fadn9907dir  `origdatadir'/eupanel9907
local fadn2dir  `origdatadir'/FADN_2/TEAGSC

* filepaths of subdirectories of nfspaneldir
local SMILEFarmdatadir `nfspaneldir'\OutData\SpatialMatch
local orig_ibsas_nfs = "`nfspaneldir'\OutData\ConvertIBSAS"
global orig_ibsas_nfs1 = "`orig_ibsas_nfs'"
local nfsdatadir `nfspaneldir'\OutData
global nfsdatadir1 = "`nfsdatadir'"

* filepaths other subdirectories of datadir
local pov_orig_data `datadir'/Data_Pov87/OutData
local censusofagdatadir `datadir'/data_WFD/Orig_data
local filldatadir `datadir'/Data_lii/Out_Data/PanelCreate/lii
local silcdatadir `datadir'/data_AIMAP/Out_Data/EUSILCBenefits
local histdata `datadir'/Data_lii/Out_Data/SMILECreate/lii
local ttw `datadir'/data_AIMAP/Orig_Data/TTW
local exp_origdatadir `datadir'/data_AIMAP/Orig_Data/ExpAnalysis
local silc_orig_data `datadir'/data_AIMAP/Out_Data/EUSILCBenefits
local hbsnfsdatadir `datadir'/data_NFSPanelAnalysis/OutData/HBSNFSMatch
*--------------------------------------------





* Do-file directories
*--------------------------------------------
local dodir `fadnpaneldir'/Do_Files/FADN_IGM
global dodir1 = "`dodir'"

local exp_dodir `datadir'/data_AIMAP/Do_Files/ExpAnalysis
local smiledodir `datadir'/Data_SmileCreate/Do_files/DoSmileCreate
*--------------------------------------------





* Output Data
*--------------------------------------------
local fadnoutdatadir `fadnpaneldir'/OutData/FADN_IGM

local outdatadir `nfspaneldir'/OutData/IGM
global outdatadir1 = "`outdatadir'"

local Regional_outdatadir /Data/data_NFSPanelAnalysis/OutData/RegionalAnalysis
global Regional_outdatadir1 = "`Regional_outdatadir'"



cd `dodir'
capture mkdir logs
log using logs/$dataname.txt, replace
di  "Job  Started  at  $S_TIME  on $S_DATE"
cmdlog using logs/$dataname_cmd.txt, replace
*--------------------------------------------





* Ensure that required directories exist
*--------------------------------------------
capture mkdir `fadnoutdatadir'
capture mkdir `origdatadir'
capture mkdir `fadn9907dir'
capture mkdir `fadn2dir'
capture mkdir output
capture mkdir output/docs
capture mkdir output/graphs
capture mkdir output/graphs
capture mkdir output/graphs/feed
capture mkdir logs/results
*--------------------------------------------





* DEFINING THE PANEL 
*---------------------------------------
* Countries available are --> "Austria Belgium Bulgaria 
*   Cyprus CzechRepublic Denmark Estonia Finland France 
*   Germany Greece Hungary Ireland Italy Latvia Lithuania 
*   Luxembourg Malta Netherlands Poland Portugal Romania 
*   Slovakia Slovenia Spain Sweden UnitedKingdom" 
global ms "France Germany Ireland UnitedKingdom" 



* Choose 2 or 3 character labels, or full labels for the
*   newly created countrycode variable (ms2, ms3, or msname)
global countrylabels "msname"



* Select farm types. You could also specify 
*   principal farmtypes, A30 codes (see #model_rica spreadsheets
*   in SupportDocs) or "*" for all obs. A30 will be
*   renamed system in sub_do/cleanvarnames.do. 
global sectors "system==4110" 



* Vars from Standard Results  (eupanel9907) that you'd like 
*   to include give a varlist, or "*" if you want all vars
global oldvars "*"



* Vars from the more specific 2nd FADN request (FADN_2)
*   give a varlist, or "*" if you want all vars
global newvars "*" 

*---------------------------------------





* BUILDING THE PANEL   
*---------------------------------------
* The gen and save commands generate a blank dataset
*   to start from. This is necessary for some of the
*   loops (avoids double counting the first
*   dataset).



* databuild.do creates dataset based on macro values
*   above from data in eupanel9907 and FADN_2/TEAGSC
*   and creates a list of the variables in the resulting
*   dataset (drops data from memory, meaning it has to 
*   be loaded again below). You can switch these lines off
*   for intermediate data runs. 
`build'gen start=1
`build'save blank, replace
`build'do sub_do/databuild.do



* ALWAYS LEAVE THESE LINES TURNED ON, EVEN IF RUNNING 
*   databuild.do again.
use `fadnoutdatadir'/$dataname.dta, clear
qui do sub_do/valuelabels.do



* rename a few FADN variable with the varname corresponding
*   to the closest match in the NFS so other do files
*   which were originally written for the NFS will run
qui do sub_do/renameFADN.do
********************************************************
********************************************************
* End of Run Parameters section
********************************************************
********************************************************








********************************************************
********************************************************
* MODELLING               
********************************************************
********************************************************



********************************************************
* Run SFA models on FADN panel
********************************************************
* final setup for running model
qui do sub_do/model_setup.do
save `fadnoutdatadir'/SFA_pre.dta, replace



* define constraint to force half normal dist of u_i (default is
* truncated normal) to use it specify const(1) as an option of
* xtfrontier command
constraint define 1 [mu]_cons = 0




* lnlandval lnmachinee lnbuildingse
* 



* SFA Models
*---------------------------------------
/*
* Time invariant model using a meta-frontier
xtfrontier `dep_vlist' `indep_vlist' `location_vlist', ti
estimates store meta_model_ti
predict meta_te_ti, te
timer off 1
timer list



timer clear 2
timer on 2
sfpanel `dep_vlist' `indep_vlist' if country=="IRE", model(bc88)
estimates store meta_model_sfpl
*predict meta_te_sfpl, te
timer off 2
*/


* Time varying decay model using a common frontier for all countries
sfpanel `dep_vlist' `indep_vlist' `location_vlist', model(bc95) emean(`indep_vlist') usigma(`indep_vlist') // <- needs a grass variable
estimates store meta_model_bc95
predict meta_te_bc95, te


/*
* Greene's True Fixed Effects
sfpanel `dep_vlist' `indep_vlist' `location_vlist', model(tfe) distribution(hnormal)
estimates store meta_model_tfe
predict meta_te_tfe 



tabstat meta_te_ti meta_te_tvd meta_te_tfe, by(country) stats(mean, sd)
*do sub_do/FarmPanelEstimation.do

*/

save `fadnoutdatadir'/SFA_post, replace
********************************************************
********************************************************
* End of MODELLING section              
********************************************************
********************************************************







********************************************************
********************************************************
* GENERATING DESCRIPTIVES 
********************************************************
********************************************************

* for supporting discussion of positive sign on hasreps in
* production function (unexpected)
corr `dep_vlist' `indep_vlist'

/*
* These do files generate output datasets and graphs. 



* Do files which create graphs
*qui do sub_do/graphs.do



* summary table 
tabstat fdairygo_lu landval_ha fdferfil_ha daforare dpnolu flabpaid flabunpd ogagehld fsizuaa fdratio if grassregion < . [weight=intwt], by(grassregion) stats(mean, sd, sem, min, max, n) columns(statistics) varwidth(32)



* create csv's of summary stats for export to spreadhsheet
qui do sub_do/spreadsheets.do
********************************************************
********************************************************
* End of GENERATING DESCRIPTIVES section
********************************************************
********************************************************







*/
********************************************************
********************************************************
*** CLEANING UP             
********************************************************
********************************************************
* Drop the global macro ms which contains the country
*   names, clear data in memory, erase blank.dta, and
*   close logs
macro drop ms sectors oldvars newvars dataname datadir orig_ibsas_nfs1 dodir1 outdatadir1 Regional_outdatadir1 countrylabels fdairygo_ha_vlist1 fdairygo_lu_vlist1 nfsdatadir1 



*clear
capture erase blank.dta
capture log close
capture cmdlog close
********************************************************



* Here's all the macros you've defined in this file
macro list



* Local macros  will automatically drop from memory when
* file completes, but globals will persist.
* Check to make sure you've dropped all global macros
* you've defined in this file by running "macro list"
* again after the file completes and comparing
* its output to what you see above.

********************************************************
********************************************************
*** End of CLEANING UP section
********************************************************
********************************************************








********************************************************
********************************************************
* OUTPUT WILL BE IN THE OUTPUT FOLDER. LOGS WILL BE IN
* THE LOGS FOLDER. DID YOU UNCOMMENT ALL THE PARTS YOU
* WANTED TO RUN?
********************************************************
********************************************************
