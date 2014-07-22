/* IB style formula


* NOTE: This variable is gross output from particular crops. 
"((
 sum(root/svy_crops[@crop_code='****']/@cy_sales_value_eu) +
 sum(root/svy_crops[@crop_code='****']/@cy_fed_value_eu) +
 sum(root/svy_crops[@crop_code='****']/@cy_closing_value_eu)
)
+
(
 (:check that we won't divide by zero, if we will return 0 - this avoids NaN:)
 if((sum(root/svy_crops[@crop_code='****']/@cy_closing_value_eu) - 
     sum(root/svy_crops[@crop_code='****']/@cy_waste_tonnes_ha)) > 0) then
 (
  sum(root/svy_crops[@crop_code='****']/@cy_allow_house_tonnes_ha) +
  sum(root/svy_crops[@crop_code='****']/@cy_allow_wages_tonnes_ha)
  )
  div
 (
  sum(root/svy_crops[@crop_code='****']/@cy_closing_value_eu) - 
  sum(root/svy_crops[@crop_code='****']/@cy_waste_tonnes_ha)
 ) else 0 
)
*
sum(root/svy_crops[@crop_code='****']/@d_total_direct_cost_eu))"


cuslv + cufdv + cuclv


*/


* Stata translation (using SAS codes)
gen fcropsgo       = ///
	ffodcpgo   + /// 
	fmisccgo   + ///
	D_OUTPUT_FROM_CURRENT_MISC_CASH_CROP



