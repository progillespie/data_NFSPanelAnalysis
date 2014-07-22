* Requires input data resulting from run of Dairy Variable Construction file (e.g. DAIRY DO FILE.do, or dairy_do_file.do)
* Investigate Attrition

* drop zero obs

* have varnames, but might be 0 vectors
*drop if Y2<=0
*drop if LANDFEED<=0
*drop if LANDFAGE<=0

* Don't have these.
*drop if L3<=0
*drop if C<=0
*drop if DC<=0
*drop if H<=0 



xtset FC T

bysort FC: egen MAXT=max(T)
bysort FC: egen MINT=min(T)

* Degree of Attrition

gen TLAG=T-l.T
replace TLAG=0 if TLAG==.

bysort T: sum TLAG

* Number of years each farm is in sample

gen onedummy=1
bysort FC: egen PS=sum(onedummy) 

* Divide these by their number. If there are 104 2s, then answer is 86/1=86

count if PS==1
count if PS==2
count if PS==3
count if PS==4
count if PS==5
count if PS==6
count if PS==7
count if PS==8
count if PS==9
count if PS==10
count if PS==11

* partial productivity indicators

*gen PH=Y2/H
*gen PD=Y2/DC
*gen PL=Y2/L3
gen PA=Y2/LANDFAGE
*gen PC=Y2/C

bysort T: sum PA

****************************************************************************

* efficiency variables DROP ZEROS IF DOING DESCRIPTIVE STATS!!!!!!!!!!!!!!!! 
 
****************************************************************************

* drop if AGE<14

* drop if AGE>100

****************************************************************************

* create OFF-FARM SIZE interactions. SMALL (0-64), MEDIUM (65-112), LARGE (112+)


gen SMALL=0
gen MEDIUM=0
gen LARGE=0

replace SMALL=1 if FSIZE<65
replace MEDIUM=1 if FSIZE<113
replace MEDIUM=0 if FSIZE<65
replace LARGE=1 if FSIZE>112

*gen SMLOFF=OFFFARM*SMALL
*gen MEDOFF=OFFFARM*MEDIUM
*gen LRGOFF=OFFFARM*LARGE




