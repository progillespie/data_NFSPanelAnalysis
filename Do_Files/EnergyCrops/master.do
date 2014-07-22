********************************************************
********************************************************
* Patrick R. Gillespie				
* Research Officer				
* Teagasc, REDP					
* Athenry, Co Galway, Ireland			
* patrick.gillespie@teagasc.ie	
*											
********************************************************
* RSF Project DAF RSF 07 505 (GO1390)		
*											
* A micro level analysis of the Irish 	
* agri-food sector: lessons and 		
* recommendations from Denmark and 	
* the Netherlands				
*										
* Task 4
*
********************************************************
* READ THE FILE README.RTF BEFORE CHANGING ANYTHING!!!
********************************************************



********************************************************
* PRELIMINARIES       
********************************************************
*
cd "<INSERT COMPLETE FILEPATH TO "analysis" FOLDER HERE>"
*
clear
clear matrix
set mem 500m
set matsize 300
capture log close
capture cmdlog close
log using logs/tg_5818, replace
cmdlog using logs/tg_5818, replace
*
* The following makes the necessary directories 
* ALWAYS KEEP THIS TURNED ON
do sub_do/make_dir.do
********************************************************



********************************************************
* DEFINING THE PANEL   
********************************************************
* The following global macros will be called by the
*   sub_do files.
* `ms' is the list of countries to be included in
*     the analysis. Values must match filenames
*     (excluding .csv) in CountryData/eupanel0407.
* `sectors' selects the general or principal
*     farmtypes to study. Must conform to if statement
*     syntax.
* `oldvars' selects the variables to keep from
*     eupanel9907
* `newvars' selects a list of variables to be included
*     from FADN_2 data. 
* `dataname' let's you choose the name of the 
*     resulting dataset (leave off the .dta... that's
*     added automatically) 
* |                           |   
* | DEFINE GLOBAL MACROS HERE |
* v                           v
global ms "Austria Belgium Bulgaria Cyprus CzechRepublic Denmark Estonia Finland France Germany Greece Hungary Ireland Italy Latvia Lithuania Luxembourg Malta Netherlands Poland Portugal Romania Slovakia Slovenia Spain Sweden UnitedKingdom" 
*
global sectors "generalfarmtype==1|generalfarmtype==8" 
*
global oldvars "_all"
*
global newvars "oilseedrapeuaa" 
*
global dataname "data9907"
********************************************************



********************************************************
* BUILDING THE PANEL   
********************************************************
* The gen and save commands generate a blank dataset
*   to start from. This is necessary for some of the
*   loops sub_do to avoid double counting the first
*   dataset
*
* databuild.do creates dataset based on macro values
*   above from data in eupanel9907 and FADN_2/TEAGSC
*
gen start=1
save blank, replace
do sub_do/databuild.do
********************************************************



********************************************************
* GENERATING DESCRIPTIVES 
********************************************************
* These do files generate output datasets and graphs. 
*
* Do files creating csv's for tables. 
*   Saves in output/spreadsheets. 
*do sub_do/allfarms
*do sub_do/energycrop
*do sub_do/tillagefarms
*
* Do files which create graphs
do sub_do/setupgph //data manipulations for Fig. 1
do sub_do/energygph //actual graphing commands
*do sub_do/altgph //saves gph in different file formats
********************************************************



********************************************************
* MODELLING               
********************************************************
* <biofuels.do> develops a model of adoption of
*   biofuels across the EU. <organics.do> develops a
*   model of adoption of organics across the EU [NOT
*   DONE YET].IF DOING AN ORGANIC PAPER, THEN SAVE 
*   THAT DO-FILE AS "organics.do" IN THE "sub_do"
*   FOLDER. YOU CAN THEN CALL IT BY UNCOMMENTING THE
*   LINE WITH organics.do BELOW]
*
do sub_do/biofuels.do
*do sub_do/organics.do 
********************************************************



********************************************************
*** CLEANING UP             
********************************************************
* Drop the global macro ms which contains the country
*   names, clear data in memory, erase blank.dta, and
*   close logs
*
macro drop ms sectors oldvars newvars dataname
clear
erase blank.dta
erase output/docs/model.txt
erase output/docs/Chow_adopt.txt
erase output/docs/Chow_time.txt
capture log close
capture cmdlog close
********************************************************



********************************************************
********************************************************
* OUTPUT WILL BE IN THE OUTPUT FOLDER. LOGS WILL BE IN
* THE LOGS FOLDER. DID YOU UNCOMMENT ALL THE PARTS YOU
* WANTED TO RUN?
********************************************************
********************************************************
