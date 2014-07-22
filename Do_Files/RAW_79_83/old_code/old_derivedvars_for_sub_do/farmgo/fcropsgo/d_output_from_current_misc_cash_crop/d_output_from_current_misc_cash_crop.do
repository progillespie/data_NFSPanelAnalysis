/* IB style formula

sum(root/svy_crops[@crop_code='1116']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1111']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1117']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1146']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1141']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1147']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1571']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1577']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1156']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1151']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1157']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1431']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1436']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1211']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1561']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1311']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1317']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1321']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1751']/@d_gross_output_eu)
+ sum(for $i in root/svy_crops 
return  
  if (not(matches($i/@crop_code, '111[0-9]'))   
    and not(matches($i/@crop_code, '115[0-9]'))   
    and not(matches($i/@crop_code, '114[0-9]'))   
    and not(matches($i/@crop_code, '157[0-9]'))   
    and not(matches($i/@crop_code, '131[0-9]'))   
    and not(matches($i/@crop_code, '132[0-9]')) 
    and not(matches($i/@crop_code, '143[0-9]'))    
    and not(matches($i/@crop_code, '146[0-9]'))   
    and not(matches($i/@crop_code, '811[0-9]'))   
    and not(matches($i/@crop_code, '921[0-9]'))   
    and not(matches($i/@crop_code, '922[0-9]'))   
    and not(matches($i/@crop_code, '923[0-9]'))   
    and not(matches($i/@crop_code, '902[0-9]'))   
    and not(matches($i/@crop_code, '903[0-9]'))   
    and not(matches($i/@crop_code, '904[0-9]'))   
    and not(matches($i/@crop_code, '905[0-9]'))   
    and not(matches($i/@crop_code, '906[0-9]'))   
    and not(matches($i/@crop_code, '907[0-9]'))  
    and not(matches($i/@crop_code, '908[0-9]' ))
    and not(matches($i/@crop_code, '175[0-9]'))) 
   then $i/@d_gross_output_eu  else 0) + 
 root/svy_subsidies_grants/@d_arable_aid + 
/root/svy_subsidies_grants/@protein_payments_total_eu



*/


* Stata translation (using SAS codes)
gen fcropsgo       = ///
	ffodcpgo   + /// 
	fmisccgo   + ///
	D_OUTPUT_FROM_CURRENT_MISC_CASH_CROP


"sum(root/svy_crops[@crop_code='1116']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1111']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1117']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1146']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1141']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1147']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1571']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1577']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1156']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1151']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1157']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1431']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1436']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1211']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1561']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1311']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1317']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1321']/@d_gross_output_eu)
"sum(root/svy_crops[@crop_code='1116']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1111']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1117']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1146']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1141']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1147']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1571']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1577']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1156']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1151']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1157']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1431']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1436']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1211']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1561']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1311']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1317']/@d_gross_output_eu) 
+ sum(root/svy_crops[@crop_code='1321']/@d_gross_output_eu)
+ sum(root/svy_crops[@crop_code='1751']/@d_gross_output_eu)
+ sum(for $i in root/svy_crops 
return  
  if (not(matches($i/@crop_code, '111[0-9]'))   
    and not(matches($i/@crop_code, '115[0-9]'))   
    and not(matches($i/@crop_code, '114[0-9]'))   
    and not(matches($i/@crop_code, '157[0-9]'))   
    and not(matches($i/@crop_code, '131[0-9]'))   
    and not(matches($i/@crop_code, '132[0-9]')) 
    and not(matches($i/@crop_code, '143[0-9]'))    
    and not(matches($i/@crop_code, '146[0-9]'))   
    and not(matches($i/@crop_code, '811[0-9]'))   
    and not(matches($i/@crop_code, '921[0-9]'))   
    and not(matches($i/@crop_code, '922[0-9]'))   
    and not(matches($i/@crop_code, '923[0-9]'))   
    and not(matches($i/@crop_code, '902[0-9]'))   
    and not(matches($i/@crop_code, '903[0-9]'))   
    and not(matches($i/@crop_code, '904[0-9]'))   
    and not(matches($i/@crop_code, '905[0-9]'))   
    and not(matches($i/@crop_code, '906[0-9]'))   
    and not(matches($i/@crop_code, '907[0-9]'))  
    and not(matches($i/@crop_code, '908[0-9]' ))
    and not(matches($i/@crop_code, '175[0-9]'))) 
   then $i/@d_gross_output_eu  else 0) + 
 root/svy_subsidies_grants/@d_arable_aid + 
/root/svy_subsidies_grants/@protein_payments_total_eu"
+ sum(root/svy_crops[@crop_code='1751']/@)
+ sum(for $i in root/svy_crops 
return  
  if (not(matches($i/@crop_code, '111[0-9]'))   
    and not(matches($i/@crop_code, '115[0-9]'))   
    and not(matches($i/@crop_code, '114[0-9]'))   
    and not(matches($i/@crop_code, '157[0-9]'))   
    and not(matches($i/@crop_code, '131[0-9]'))   
    and not(matches($i/@crop_code, '132[0-9]')) 
    and not(matches($i/@crop_code, '143[0-9]'))    
    and not(matches($i/@crop_code, '146[0-9]'))   
    and not(matches($i/@crop_code, '811[0-9]'))   
    and not(matches($i/@crop_code, '921[0-9]'))   
    and not(matches($i/@crop_code, '922[0-9]'))   
    and not(matches($i/@crop_code, '923[0-9]'))   
    and not(matches($i/@crop_code, '902[0-9]'))   
    and not(matches($i/@crop_code, '903[0-9]'))   
    and not(matches($i/@crop_code, '904[0-9]'))   
    and not(matches($i/@crop_code, '905[0-9]'))   
    and not(matches($i/@crop_code, '906[0-9]'))   
    and not(matches($i/@crop_code, '907[0-9]'))  
    and not(matches($i/@crop_code, '908[0-9]' ))
    and not(matches($i/@crop_code, '175[0-9]'))) 
   then $i/@d_gross_output_eu  else 0) + 
 root/svy_subsidies_grants/@d_arable_aid + 
/root/svy_subsidies_grants/@protein_payments_total_eu"

