*****************************************************
*****************************************************
* NFs Panel Creation 
*
* (c) Cathal O’Donoghue, John Lennon RERC Teagasc.
*
* 2009
*
*
*****************************************************
*****************************************************
clear
*originally 930, but got r(909) on my laptop, due to XP's memory management (plenty of memory, but not in a contiguous space)
set mem 915m  
set more off
set matsize 300
version 9.0
capture log close

cd d:
capture log close
local datadir d:\pglocal\data\data_NFSPanelAnalysis
local dirdatadir d:\pglocal\data\data_NFSPanelAnalysis\missingdata
local missingdatadir d:\pglocal\data\data_NFSPanelAnalysis\missingdata
local outputdatadir d:\pglocal\data\data_NFSPanelAnalysis\OutData
local origdatadir d:\pglocal\data\data_NFSPanelAnalysis\OrigData
local dodatadir d:\pglocal\data\data_NFSPanelAnalysis\Do_Files
local DPmissingdatadir d:\pglocal\data\data_NFSPanelAnalysis\missingdata\Dirpayts-missing_variables

cd `datadir'

log using missingdata_create_panel.log, replace 
di  "Job  Started  at  $S_TIME  on $S_DATE"





***********************************************************
***********************************************************
** Raw Data (BIG)
***********************************************************
***********************************************************

*********
** 1994
*********
cd `origdatadir'\
cd 1994

insheet using 1994Var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 1994Var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 1994Var410-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 1994Var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 1994Var784-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 1994Var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 1994var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 1994var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 1994var1561-1792.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 1994var1793-2024.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 1994var2025-2256.csv, clear
sort ffarmcod
save tmp11, replace


use tmp1.dta, clear
sort ffarmcod
gen year = 1994
local i = 2
while `i'<=11 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata1994.dta,replace


*********
** 1995
*********
cd `origdatadir'\
cd 1995

insheet using 1995Var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 1995Var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 1995Var410-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 1995Var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 1995Var784-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 1995Var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 1995var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 1995var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 1995var1561-1792.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 1995var1793-2024.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 1995var2025-2256.csv, clear
sort ffarmcod
save tmp11, replace


use tmp1.dta, clear
sort ffarmcod
gen year = 1995
local i = 2
while `i'<=11 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata1995.dta,replace



*********
** 1996
*********
cd `origdatadir'\
cd 1996

insheet using 1996Vars1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 1996Vars227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 1996Vars410-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 1996Vars576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 1996Vars784-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 1996Vars865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 1996vars1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 1996vars1329-1560.csv, clear
sort ffarmcod
save tmp8, replace

use tmp1.dta, clear
gen year = 1996
local i = 2
while `i'<= 8 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata1996.dta,replace


*********
** 1997
*********
cd `origdatadir'\
cd 1997

insheet using 1997var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 1997var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 1997var410-576.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 1997var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 1997var784-980.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 1997var981-1212.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 1997var1213-1444.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 1997var382-409.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 1997var1561.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 1997vars1445-1676.csv,clear
sort ffarmcod
save tmp10, replace
insheet using 1997var865-980.csv,clear
sort ffarmcod
save tmp11, replace

use tmp1.dta, clear
gen year = 1997
local i = 2
while `i'<= 11 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata1997.dta,replace



*********
** 1998
*********
cd `origdatadir'\
cd 1998

insheet using 1998var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 1998var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 1998var410-576.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 1998var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 1998var784-980.csv,clear
sort ffarmcod
save tmp5, replace
insheet using 1998var981-1212.csv,clear
sort ffarmcod
save tmp6, replace
insheet using 1998var1213-1444.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 1998var1445-1676.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 1998var1677-1908.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 1998var1909-2140.csv, clear
sort ffarmcod
save tmp10, replace

use tmp1.dta, clear
gen year = 1998
local i = 2
while `i'<= 10 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata1998.dta,replace




*********
** 1999
*********
cd `origdatadir'\
cd 1999

insheet using 1999var18-262.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 1999var263-488.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 1999var489-688.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 1999var689-864.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 1999var865-1096.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 1999var1097-1328.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 1999var1329-1560.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 1999var1561-1792.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 1999var1793-2024.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 1999var2025-2256.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 1999var688.csv, clear
sort ffarmcod
save tmp11, replace

use tmp1.dta, clear
gen year = 1999
local i = 2
while `i'<= 11 {

	di  "Year" `i'
	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata1999.dta,replace




*********
** 2000
*********
cd `origdatadir'\
cd 2000

insheet using 2000var1-134.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2000var135-488.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2000var489-688.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2000var576-783.csv,clear
sort ffarmcod
save tmp4, replace
insheet using 2000var784-864.csv,clear
sort ffarmcod
save tmp5, replace
insheet using 2000var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2000var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2000var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2000var2141-2198.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2000var1561-1618.csv,clear
sort ffarmcod
save tmp10, replace
insheet using 2000var227-409.csv, clear
sort ffarmcod
save tmp11, replace
insheet using 2000var688.csv,clear
sort ffarmcod
save tmp12, replace
insheet using 2000var135-381.csv, clear
sort ffarmcod
save tmp13, replace
sort ffarmcod

use tmp1.dta, clear
gen year = 2000
local i = 2
while `i'<= 13 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2000.dta,replace



*********
** 2001
*********
cd `origdatadir'\
cd 2001

insheet using 2001var1-134.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2001var135-488.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2001var489-688.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2001var784-864.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2001var576-783.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2001var784-864.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2001var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2001var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2001var227-409.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2001var1516-1618.csv,clear
sort ffarmcod
save tmp10, replace
insheet using 2001var783.csv,clear
sort ffarmcod
save tmp11, replace
insheet using 2001var135-163177-186187-196197-226276-286287-307335-381.csv,clear
sort ffarmcod
save tmp12, replace
insheet using 2001var865-10961.csv,clear
sort ffarmcod
save tmp13, replace

use tmp1.dta, clear
gen year = 2001
local i = 2
while `i'<= 13 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2001.dta,replace




*********
** 2002
*********
cd `origdatadir'\
cd 2002

insheet using 2002var18-133.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2002var135-185.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2002var275-284.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2002var306-332.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2002var380-407.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2002var414-486.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2002var487-505.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2002var506-566.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2002var585-603.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2002var611-686.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 2002var784-864.csv, clear
sort ffarmcod
save tmp11, replace
insheet using 2002var687-771.csv, clear
sort ffarmcod
save tmp12, replace
insheet using 2002Var811-1116.csv, clear
sort ffarmcod
save tmp13, replace
insheet using 2002var1095-1326.csv, clear
sort ffarmcod
save tmp14, replace
insheet using 2002var1327-1558.csv, clear
sort ffarmcod
save tmp15, replace
insheet using 2002vardafedare.csv,clear
sort ffarmcod
save tmp16, replace
insheet using 2002var1561-1792.csv,clear
sort ffarmcod
save tmp17, replace
insheet using 2002var227-262_382-409.csv,clear
sort ffarmcod
save tmp18, replace
insheet using 2002var569-575.csv, clear
sort ffarmcod
save tmp19, replace
insheet using 2002var576-586600-603.csv , clear
sort ffarmcod
save tmp20, replace
insheet using 2002var610-612.csv, clear
sort ffarmcod
save tmp21, replace
insheet using 2002var187-196197-226263-276276-286287-307335-343346-381.csv, clear
sort ffarmcod
save tmp22, replace

use tmp1.dta, clear
gen year = 2002
local i = 2
while `i'<= 22 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2002.dta,replace






*********
** 2003
*********
cd `origdatadir'\
cd 2003

insheet using 2003Var1-59.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2003Var65-133.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2003Var196-225.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2003Var306-332.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2003Var408-486.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2003Var487-573.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2003var489-688.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2003Var574-686.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2003var689-864.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2003var865-1096.csv,clear
sort ffarmcod
save tmp10, replace
insheet using 2003var1097-1328.csv,clear
sort ffarmcod
save tmp11, replace
insheet using 2003var1329-1560.csv,clear
sort ffarmcod
save tmp12, replace
insheet using 2003var1561-1792.csv, clear
sort ffarmcod
save tmp13, replace
insheet using 2003var1793-2024.csv, clear
sort ffarmcod
save tmp14, replace
insheet using 2003var2025-2256.csv, clear
sort ffarmcod
save tmp15, replace
insheet using 2003var1561-1618.csv, clear
sort ffarmcod
save tmp16, replace
insheet using 2003var164-173.csv, clear
sort ffarmcod
save tmp17, replace
insheet using 2003var177-186.csv, clear
sort ffarmcod
save tmp18, replace
insheet using 2003var135-163.csv, clear
sort ffarmcod
save tmp19, replace
insheet using 2003var187-196.csv, clear
sort ffarmcod
save tmp20, replace
insheet using 2003var263-276277-286287-307335-381.csv, clear
sort ffarmcod
save tmp21, replace


use tmp1.dta, clear

gen year = 2003
local i = 2
while `i'<= 21 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2003.dta,replace







*********
** 2004
*********
cd `origdatadir'\
cd 2004

insheet using 2004var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2004var227-334.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2004var335-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2004var576-688.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2004var689-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2004var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2004var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2004var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2004var1561-1792.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2004var1793-2024.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 2004var2025-2256.csv, clear
sort ffarmcod
save tmp11, replace

use tmp1.dta, clear

gen year = 2004
local i = 2
while `i'<= 11 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2004.dta,replace





*********
** 2005
*********
cd `origdatadir'\
cd 2005

insheet using 2005var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2005var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2005var410-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2005var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2005var689-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2005var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2005var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2005var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2005var1561-1792.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2005var1793-2024.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 2005var2025-2256.csv, clear
sort ffarmcod
save tmp11, replace
insheet using 2005var1561-1618.csv, clear
sort ffarmcod
save tmp12, replace
insheet using 2005var346-409.csv, clear
sort ffarmcod
save tmp13, replace

use tmp1.dta, clear

gen year = 2005
local i = 2
while `i'<= 13 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2005.dta,replace





*********
** 2006
*********
cd `origdatadir'\
cd 2006

insheet using 2006var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2006var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2006var410-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2006var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2006var784-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2006var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2006var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2006var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2006var1561-1792.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2006var1793-2024.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 2006var2025-2256.csv, clear
sort ffarmcod
save tmp11, replace

use tmp1.dta, clear

gen year = 2006
local i = 2
while `i'<= 11 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2006.dta,replace




*********
** 2007
*********
cd `origdatadir'\
cd 2007

insheet using 2007var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2007var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2007var410-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2007var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2007var784-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2007var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2007var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2007var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2007var1561-1792.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2007var1793-2024.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 2007var2025-2256.csv, clear
sort ffarmcod
save tmp11, replace

use tmp1.dta, clear

gen year = 2007
local i = 2
while `i'<= 11 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2007.dta,replace



*********
** 2008
*********
cd `origdatadir'\
cd 2008

insheet using 2008var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2008var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2008var410-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2008var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2008var784-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2008var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2008var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2008var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2008var1561-1792.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2008var1793-2024.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 2008var2025-2256.csv, clear
sort ffarmcod
save tmp11, replace

use tmp1.dta, clear

gen year = 2008
local i = 2
while `i'<= 11 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2008.dta,replace


*********
** 2009
*********
cd `origdatadir'\
cd 2009

insheet using 2009var1-226.csv, clear
sort ffarmcod
save tmp1, replace
insheet using 2009var227-409.csv, clear
sort ffarmcod
save tmp2, replace
insheet using 2009var410-575.csv, clear
sort ffarmcod
save tmp3, replace
insheet using 2009var576-783.csv, clear
sort ffarmcod
save tmp4, replace
insheet using 2009var784-864.csv, clear
sort ffarmcod
save tmp5, replace
insheet using 2009var865-1096.csv, clear
sort ffarmcod
save tmp6, replace
insheet using 2009var1097-1328.csv, clear
sort ffarmcod
save tmp7, replace
insheet using 2009var1329-1560.csv, clear
sort ffarmcod
save tmp8, replace
insheet using 2009var1561-1792.csv, clear
sort ffarmcod
save tmp9, replace
insheet using 2009var1793-2024.csv, clear
sort ffarmcod
save tmp10, replace
insheet using 2009var2025-2256.csv, clear
sort ffarmcod
save tmp11, replace

use tmp1.dta, clear

gen year = 2009
local i = 2
while `i'<= 11 {

	sort ffarmcod
	merge ffarmcod using tmp`i'.dta
	erase tmp`i'.dta
	drop _merge

	local i=`i'+1
}
cd `origdatadir'\
save rawdata2009.dta,replace


*********
** Master File
*********


use rawdata1994.dta, clear
local i = 1995
while `i'<= 2009 {

	append using rawdata`i'.dta
	erase rawdata`i'.dta

	local i=`i'+1
}
*erase rawdata1994.dta

*eliminate duplicates
sort ffarmcod year
by ffarmcod year: egen rnk = rank(ffarmcod), unique
keep if rnk == 1
drop rnk

compress
sort ffarmcod year
cd `origdatadir'\
rename ffarmcod farmcode
sort farmcode year

***********************************************************
***********************************************************
** Convert to Euro
***********************************************************
***********************************************************

*convert to numeric

foreach var in icmksubv {
	encode `var', gen(`var'1)
	drop `var'
	rename `var'1 `var'

}


foreach var in fainvfrm farmgo farmdc farmgm farmohct farmffi fincldlt finvchg fprdconh fgsalrec fcropsal flivsale fslothlv flivpur fprothlv fvalflab fmgmivti fntcapex fdpurcon fdpurblk fdferfil fdcrppro fdpursed fdmachir fdtrans fdlivmnt fdaifees fdvetmed fdcaslab fdmqleas fdmiscel fdmisclv fdmisccp fdexpend fdfodadj fdtotal fdnotalt forntcon focarelp fohirlab fointpay fomacdpr fomacopt foblddpr fobldmnt fodprlim foupkpld foexlime foannuit forates foinsure fofuellu foelecfs fophonfs folabexp fortfmer fortnfer foinhacq fomiscel fototal ftotalct fdairygo fdairydc fdairygm fcatlego fcatledc fcatlegm fsheepgo fsheepdc fsheepgm fpigsgo fpigsdc fpigsgm fpoultgo fpoultdc fpoultgm fhorsego fhorsedc fhorsegm fothergo fotherdc fothergm flivstgo flivstdc flivstgm ffodcpgo ffodcpdc ffodcpgm fmisccgo fmisccdc fcropsgo fcropsdc fcropsgm fcplivgo fcrlivdc fcplivgm frhiremh frevoth fgrntsub finttran fvopcshc fvclcshc fvopfodc fvclfodc fvopstor fvclstor fvoplvst fvcllvst fvopotlv fvclotlv fcarcliv fcardepr fcarfuel fcarrepr fcartax fcarinsu fcartcst fcarpurc fcarsale icopinvv icpurval icallval icclinvv icalldyv icallcvl icallsvl icallhvl icallpgv icalldrv icallgvl icwastev icmksubv ivmopinv ivmclinv ivmpurch ivmallpg iaisfpig ivmallpy ivmalldy iaisfdy ivmallc iaisfcat ivmallsp iaisfshp ivmallh iaisfhrs ivmalldr ivmallg ivmallol ivmalltl ivmspvet ivmmedpr itepigs imiscpig itepolty imiscpty itedairy imiscdry itecattl imiscctl itesheep imiscshp itehorse imischrs imiscder imiscgts imiscolv itemcall fgrtsubs fslturfv fmiscrec fvmisuhs foopinfl fopurflv foclinfl fomacrpr fomactax fomacins fobldins foaccfee foadvfee flabccdy flabccct flabccsh flabccpg flabccpy flabccdr flabccgt flabccol flabccna flabcctl faprpmac fagrpmac famrpmac faslpmac fapromac fagromac famromac faslomac factnbld famrblds fagrblds faldimpr fagrlimp fapcpimp fagrpcrp favlfrby faprldvl faslldvl favlfrey ooinchld ooginchd ibhayavl ibhaydvl ibhaycvl ibhaysvl ibhayhvl ibhaypvl ibstravl ibstrdvl ibstrcvl ibstrsvl ibstrhvl ibstrpvl ibsilavl ibsildvl ibsilcvl ibsilsvl ibsilhvl ibsilpvl fbelopbl fbelclbl fbnlamtb fbnlclbl fbintpay fbtermlg fbtermmd fbtermst fbovdrft fbhirepr fbsrcacc fbsrcfco fbsrcbnk fbsrcoth fbsrccop fbsrcend fbpurlvs fbpurmac fbpurlim fbpurlpr fbpurbld fbpurmkq fbpurewq fbpurscq fbpurfor fbpuraer fbpuroth fsubhors fsubtbco fsubforh fsubreps fsubsccp fsubsctp fsub10cp fsub10tp fsub22cp fsub22tp fsubspcp fsubsppp fsubsptp fsubexcp fsubexpp fsubextp fsubchcp fsubchtp fsubepcp fsubeptp fsubshcp fsubshpp fsubshtp fsubaspd fsubascp fsubaspp fsubastp fsubcapd fsubcacp fsubcapp fsubcatp fsubrppd fsubrpcp fsubrppp fsubrptp fsubpbpd fsubpbcp fsubpbpp fsublipd fsublicp fsublipp fsubmzpd fsubmzcp fsubmzpp fsubmztp dpopinvd dpclinvd dogrosso doslmkvl doslcmvl domlkpen domlkbon dosllmvl dompfrvl domkfdvl domkalvl dotomkvl dovlcnod docfslvl docftfvl doschbvl dovalclf dosldhrd doprdhrd dosubsvl doreplct dogpcomp ddconval ddpastur ddwinfor ddtotfed ddmiscdc ddtotdc ddgrsmar ddslvpay ddleaseq dqvalueq dqmcleas dqctbuy dqinhrvl dqifqlet dqvqsold dqcespay davmknpd covalcno coprcfvl coslcfvl coprwnvl coslwnvl coprstvl coslstvl coprocvl coslocvl coserrec cdtotfed cdmiscdc cdtotldc cssuckcw cs10mtbf cs22mtbf csslaugh csheadag soslhgvl sovalcno sdother sdtotldc ppopinvp ppclinvp pogrosso posalesv popurchv povalcno posubsid poslwnvl poprwnvl poslfpvl poslbpvl poprbpvl poslcsbv pohsecon pdtotfed pdvetmed pdtrans pdmiscdc pdtotldc pdprconv pdgrsmar epopinvp epclinvp eogrosso eosleggs eoslplyv eoprplyv eoprothf eoslothf eosubsid edtotldc hpopinvh hpclinvh hogrosso hosalesh hopurchh hdtotldc hdgrsmar wwhopopv wwhopslv wwhopfdv wwhopsdv wwhopclv wwhcuslv wwhcufdv wwhcusdv wwhcuclv wwhcufrv wwhcusev wwhcuspv wwhcucpv wwhcufgv wwhcuhbv wwhcuinv wwhcutcv wwhcutsv wwhcumhv wwhcucwv wwhcumcv wwhcudcv wwhcugov wwhcugmv wwhopgov wwhopdcv swhopopv swhopslv swhopfdv swhopsdv swhopclv swhcuslv swhcufdv swhcusdv swhcuclv swhcufrv swhcusev swhcuspv swhcucpv swhcufgv swhcuhbv swhcuinv swhcutcv swhcutsv swhcumhv swhcucwv swhcumcv swhcudcv swhcugov swhcugmv swhopgov swhopdcv wbyopopv wbyopslv wbyopfdv wbyopsdv wbyopclv wbycuslv wbycufdv wbycusdv wbycuclv wbycufrv wbycusev wbycuspv wbycucpv wbycufgv wbycuhbv wbycuinv wbycutcv wbycutsv wbycumhv wbycucwv wbycumcv wbycudcv wbycugov wbycugmv wbyopgov wbyopdcv sbyopopv sbyopslv sbyopfdv sbyopsdv sbyopclv sbycuslv sbycufdv sbycusdv sbycuclv sbycufrv sbycusev sbycuspv sbycucpv sbycufgv sbycuhbv sbycuinv sbycutcv sbycutsv sbycumhv sbycucwv sbycumcv sbycudcv sbycugov sbycugmv sbyopgov sbyopdcv mbycufrv mbycusev mbycuspv mbycucpv mbycufgv mbycuhbv mbycuinv mbycutcv mbycumhv mbycucwv mbycumcv mbycudcv mbyopdcv wotcufrv wotcusev wotcuspv wotcucpv wotcufgv wotcuhbv wotcuinv wotcutcv wotcutsv wotcumhv wotcucwv wotcumcv wotcudcv wotcugov wotcugmv wotopgov wotopdcv sotcufrv sotcusev sotcuspv sotcucpv sotcufgv sotcuhbv sotcuinv sotcutcv sotcutsv sotcumhv sotcucwv sotcumcv sotcudcv sotcugov sotcugmv sotopgov sotopdcv sot00001 osrcufrv osrcusev osrcuspv osrcucpv osrcufgv osrcuhbv osrcuinv osrcutcv osrcutsv osrcumhv osrcucwv osrcumcv osrcudcv osrcugov osrcugmv osropgov osropdcv osr00001 pbscufrv pbscusev pbscuspv pbscucpv pbscufgv pbscuhbv pbscuinv pbscutcv pbscutsv pbscumhv pbscucwv pbscumcv pbscudcv pbscugov pbscugmv pbsopgov pbsopdcv pbs00001 lsdcufrv lsdcusev lsdcuspv lsdcucpv lsdcufgv lsdcuhbv lsdcuinv lsdcutcv lsdcutsv lsdcumhv lsdcucwv lsdcumcv lsdcudcv lsdcugov lsdcugmv lsdopgov lsdopdcv lsd00001 potcufrv potcusev potcuspv potcucpv potcufgv potcuhbv potcuinv potcutcv potcutsv potcumhv potcucwv potcumcv potcudcv potcugov potcugmv potopgov potopdcv pot00001 sbecufrv sbecusev sbecuspv sbecucpv sbecufgv sbecuhbv sbecuinv sbecutcv sbecutsv sbecumhv sbecucwv sbecumcv sbecudcv sbecugov sbecugmv sbeopgov sbeopdcv sbe00001 {

	replace `var' = `var'*1.27 if year <= 1998
* todo check to see if already converted to euro
*	replace `var' = `var'*1 if year <= 2001
}

do `dodatadir'\PriceIndexCalc.do

***********************************************************
** Convert to Hectare
***********************************************************


foreach var in fsizunad fsizgzac fsizpsac fsizeadj fsizldow fsizldrt fsizldlt fsizfdac fsizcrps fsiz1hay fsiz2hay fsiz3hay fsizslg1 fsizslg2 fsizslg3 fsizajhy fsizajsl fsizrgac fsizrema fsizfort fsizrgeq fsizcmeq fsizrtfe fsizrtne cpforacs cpfedacs spforacs spfedacs hpforacs faprldac faslldac fsubasac fsubcaac fsubrpac fsubpbac fsubliac daforare dafedare wwhcuarq wwhcuarq swhcuarq wbycuarq sbycuarq mbycuarq  wotcuarq sotcuarq osrcuarq pbscuarq lsdcuarq  potcuarq sbecuarq fbtcuarq tmscuarq aslcuarq  mslcuarq ofdcuarq stwcuarq haycuarq silcuarq  forcuarq sbtcuarq othcuarq {
	replace `var' = `var'/2.47105 if year <= 2005
}


save `outputdatadir'\nfs_data, replace


***********************************************************
***********************************************************
** Regional Analysis
***********************************************************
***********************************************************
local Regional_origdatadir d:\pglocal\data\data_NFSPanelAnalysis\OrigData\RegionalAnalysis

local Regional_dodir d:\pglocal\data\data_NFSPanelAnalysis\Do_Files\RegionalAnalysis
local Regional_outdatadir d:\pglocal\data\data_NFSPanelAnalysis\OutData\RegionalAnalysis

cd `Regional_origdatadir'

*Create Stata files
local i = 1997
while `i'<= 2008 {

	insheet using `i'regionalweights.csv, clear
	gen year = `i'
	save `i'regionalweights.dta,replace
	local i=`i'+1
}

use 1997regionalweights.dta, clear
erase 1997regionalweights.dta
local i = 1998
while `i'<= 2008 {
	append using `i'regionalweights.dta
	erase `i'regionalweights.dta
	local i=`i'+1
}

rename ffarmcod farmcode
sort farmcode year

save `Regional_outdatadir'\regional_weights.dta, replace

***********************************************************
***********************************************************
** Environmental and Economic Sustainability Indicators
***********************************************************
***********************************************************

local Indicator_dodir d:\pglocal\data\data_NFSPanelAnalysis\Do_Files\IndicatorAnalysis
local Indicator_datadir d:\pglocal\data\data_NFSPanelAnalysis\OutData\IndicatorAnalysis

cd `Indicator_datadir'

*Economic Indicator Analysis
use `outputdatadir'\nfs_data.dta, clear
*do `Indicator_dodir'\EconIndicatorsAnalysis.do


*Environmental Indicator Analysis
use `outputdatadir'\nfs_data.dta, clear
sort year
merge year using stephen_env_data.dta
drop _merge

*do `Indicator_dodir'\EnvIndicatorsAnalysis.do

***********************************************************
***********************************************************
** Inequality Analysis
***********************************************************
***********************************************************

local Inequality_dodir d:\pglocal\data\data_NFSPanelAnalysis\Do_Files\InequalityAnalysis
local Inequality_datadir d:\pglocal\data\data_NFSPanelAnalysis\OutData\InequalityAnalysis

cd `Inequality_dodir'
use `outputdatadir'\nfs_data.dta, clear
*do `Inequality_dodir'\doFarmIneqAnalysis.do
capture erase NFS1.dta

***********************************************************
***********************************************************
** HBS NFS Match
***********************************************************
***********************************************************

local HBSNFSMatch_dodir d:\pglocal\data\data_NFSPanelAnalysis\Do_Files\HBSNFSMatch
local HBSNFSMatch_datadir d:\pglocal\data\data_NFSPanelAnalysis\OutData\HBSNFSMatch

cd `HBSNFSMatch_dodir'
use `outputdatadir'\nfs_data.dta, clear
*do `HBSNFSMatch_dodir'\HBSNFSMatch.do
*drop if shashbsdata == 0
*save `HBSNFSMatch_datadir'\hbs_nfs_match.dta, replace

***********************************************************
***********************************************************
** Farm Partnership Analysis
***********************************************************
***********************************************************

local FarmPartnership_dodir d:\pglocal\data\data_NFSPanelAnalysis\Do_Files\FarmPartnershipAnalysis
local FarmPartnership_datadir d:\pglocal\data\data_NFSPanelAnalysis\OutData\FarmPartnershipAnalysis

cd `FarmPartnership_dodir'
use `outputdatadir'\nfs_data.dta, clear
*do `FarmPartnership_dodir'\FarmPartnershipModel.do
