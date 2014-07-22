/* IB style formula

SVY_CROP_DERIVED @ D_GROSS_OUTPUT_FODDER_CROPS_SOLD_EU  +
SVY_CROP_DERIVED @ D_OUTPUT_FROM_INV_MISC_CASH_CROP_EU  +
SVY_CROP_DERIVED @ D_OUTPUT_FROM_CURRENT_MISC_CASH_CROP



*/


* Stata translation (using SAS codes)
gen fcropsgo       = ///
	ffodcpgo   + /// 
	fmisccgo   + ///
	D_OUTPUT_FROM_CURRENT_MISC_CASH_CROP
