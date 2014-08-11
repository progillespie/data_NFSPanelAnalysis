* Calculate var not derived var, but not in historical data. 
local code = 9211
capture drop ALLOCATED_TO_CROP_EU`code'
gen ALLOCATED_TO_CROP_EU`code' = 0
local i = 1
while `i' < 7 {

	replace ALLOCATED_TO_CROP_EU`code' = ///
	  ALLOCATED_TO_CROP_EU`code'           + /// 
	  ALLOCATED_TO_CROP`i'_EU                ///
	  if CROP`i'_CODE == `code'

	local i = `i' + 1

}

