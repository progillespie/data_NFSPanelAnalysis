**********************************************************************
**********************************************************************
* Price Calculator
**********************************************************************
**********************************************************************

local dodir = "$dodir1"
local OutData = "$OutData1"
local vlist = "$prvlist"
local volchange = sc_volchange
local pricechange = sc_pricechange

foreach var in `vlist' {

	*Directory
	local dir = "`var'_ind"
	di "`dir'"

	* Log Outputs
	capture log close
	log using "`OutData'\Logs\\`var'_`volchange'`pricechange'.log", replace

		*Fertiliser
	if sc_`var' == 0 {
		local var1 = "Fertiliser"
		*Assign Global Vars
		global var1 = "`var'"
		* Create Price
		do `dodir'\PC_`var1'.do
	}
	*CropGO
	if sc_`var' == 1 {
		local var1 = "CropGO"
		*Assign Global Vars
		global var1 = "`var'"
		* Create Price
		do `dodir'\PC_`var1'.do
	}
	*CropExpenses
	if sc_`var' == 2 {
		local var1 = "CropExpenses"
		*Assign Global Vars
		global var1 = "`var'"
		* Create Price
		do `dodir'\PC_`var1'.do
	}
	

	*General (Test)
	if sc_`var' == 3 {
		local var1 = "Test"
		*Assign Global Vars
		global var1 = "`var'"
		* Create Price
		do `dodir'\PC_`var1'.do
		
	}
	*BulkyFeed
	if sc_`var' == 4 {
		local var1 = "Bulkyfeed"
		*Assign Global Vars
		global var1 = "`var'"
		* Create Price
		do `dodir'\PC_`var1'.do

	}
	*PriceOnly
	if sc_`var' == 5 {
		local var1 = "PriceOnly"
		*Assign Global Vars
		global var1 = "`var'"
		* Create Price
		do `dodir'\PC_`var1'.do
	}
	*Milk
	if sc_`var' == 6 {
		local var1 = "Milk"
		*Assign Global Vars
		global var1 = "`var'"
		* Create Price
		do `dodir'\PC_`var1'.do
	}
	
	log close
}
local i = `i' + 1
