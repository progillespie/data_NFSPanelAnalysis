/* IB style formula

sum(root/svy_crops[@crop_code=(
'1110'   whopopv
'1140'   byopopv
'1150'   otopopv
'1430'   osropopv
'1210'   opopv_1210
'1560'   lsdopopv
'1570'   mbyopopv
'1310'   potopopv
'1320'   sbeopopv
'1270'   opopv_1270
'1280'   opopv_1280
'1290'   opopv_1290
)] /@op_inv_fed_value_eu)          +

sum(root/svy_crops[@crop_code=(
'1116'   wwhcufdv          
'1111'   swhcufdv          	       
'1117'   whcufdv            
'1146'   wbycufdv
'1141'   sbycufdv
'1147'   bycufdv
'1571'   mbycufdv
'1156'   wotcufdv
'1151'   sotcufdv
'1431'   osrcufdv
'1211'   cufdv_1211
'1561'   lsdcufdv
'1311'   potcufdv
'1321'   sbecufdv
'1271'   cufdv_1271
'1281'   cufdv_1281
'1286'   cufdv_1286
'1291'   cufdv_1291
)]/@cy_fed_value_eu)

RAW DATA POSITIONS
op_inv_fed_value_eu 04_10     *opfdv variables
cy_fed_value_eu     05_10     *cufdv variables

The summing of multi lines by crop code is already done by this point, 
 so now just add the different crop specific variables. Also, some of 
 these crop codes don't yet have a SAS abbreviation, so they are ID'ed
 with a _ followed by the code.

*/

* Some vars not found in data (may not have existed). 
foreach var of varlist       ///
  osropopv                   ///                 
  opopv_1210                 ///                   
  sbeopopv                   ///                 
  opopv_1270                 ///                   
  opopv_1280                 ///                   
  opopv_1290                 ///                   
  cufdv_1211                 ///                   
  cufdv_1271                 ///                   
  cufdv_1281                 ///                   
  cufdv_1286                 ///                   
  cufdv_1291                 {                   

	capture drop `var'
	gen `var' = 0

}



* Stata translation (using SAS codes)
capture drop cash_crops_fed_eu 
gen cash_crops_fed_eu =  ///
	whopopv       +  /// 
	byopopv       +  /// 
	otopopv       +  /// 
	osropopv      +  /// 
	opopv_1210    +  /// 
	lsdopopv      +  /// 
	mbyopopv      +  /// 
	potopopv      +  /// 
	sbeopopv      +  /// 
	opopv_1270    +  /// 
	opopv_1280    +  /// 
	opopv_1290    +  /// 
	wwhcufdv      +  /// 
	swhcufdv      +  /// 
	whcufdv       +  /// 
	wbycufdv      +  /// 
	sbycufdv      +  /// 
	bycufdv       +  /// 
	mbycufdv      +  /// 
	wotcufdv      +  /// 
	sotcufdv      +  /// 
	osrcufdv      +  /// 
	cufdv_1211    +  /// 
	lsdcufdv      +  /// 
	potcufdv      +  /// 
	sbecufdv      +  /// 
	cufdv_1271    +  /// 
	cufdv_1281    +  /// 
	cufdv_1286    +  /// 
	cufdv_1291     

* Above still needs work

