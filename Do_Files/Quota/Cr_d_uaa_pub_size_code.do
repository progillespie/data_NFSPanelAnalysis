capture drop d_uaa_pub_size_code 
gen d_uaa_pub_size_code = 0 
replace d_uaa_pub_size_code = 1 if UAA_SIZE >= 2  & UAA_SIZE < 10  & D_SOIL_GROUP != 3
replace d_uaa_pub_size_code = 2 if UAA_SIZE >= 10 & UAA_SIZE < 20  & D_SOIL_GROUP != 3
replace d_uaa_pub_size_code = 3 if UAA_SIZE >= 20 & UAA_SIZE < 30  & D_SOIL_GROUP != 3
replace d_uaa_pub_size_code = 4 if UAA_SIZE >= 30 & UAA_SIZE < 50  & D_SOIL_GROUP != 3
replace d_uaa_pub_size_code = 5 if UAA_SIZE >= 50 & UAA_SIZE < 100 & D_SOIL_GROUP != 3
replace d_uaa_pub_size_code = 6 if UAA_SIZE >= 100 & D_SOIL_GROUP != 3
replace d_uaa_pub_size_code = 7 if D_SOIL_GROUP == 3
replace d_uaa_pub_size_code = 8 if FARM_SYSTEM  == 8
replace d_uaa_pub_size_code = D_UAA_PUB_SIZE_CODE if YE_AR > 1983

capture label drop d_uaa_pub_size_code
label var d_uaa_pub_size_code "Size strata"
label define d_uaa_pub_size_code ///
  0 "Not classified" ///
  1 "  2- 10 ha" ///
  2 " 10- 20 ha" ///
  3 " 20- 30 ha" ///
  4 " 30- 50 ha" ///
  5 " 50-100 ha" ///
  6 "  > 100 ha" ///
  7 "Hill farms" ///
  8 "Other farms"
label values d_uaa_pub_size_code d_uaa_pub_size_code

br FARM_CODE YE_AR UAA_SIZE FARM_SYSTEM if d_uaa_pub_size_code == 0 & UAA_SIZE > 2

tab d_uaa_pub_size_code YE_AR, column nofreq
