/* IB style formula

D_TOTAL_LIVESTOCK_GROSS_OUTPUT = 
   svy_dairy_produce/ @ d_dairy_gross_output_eu          + 
   svy_cattle/        @ d_gross_output_cattle_eu         + 
   svy_sheep/         @ d_gross_output_sheep_and_wool_eu + 
   svy_pigs/          @ d_gross_output_pigs_eu           + 
   svy_poultry/       @ d_poultry_gross_output_eu        + 
   svy_horses_other/  @ d_gross_output_horses_eu         + 
   svy_farm/          @ d_other_gross_output_eu

*/


* Stata translation (using SAS codes)
gen flivstgo       = ///
	fdairygo   + /// or dogrosso, fdairygo is preferred
	fcatlego   + ///
	fsheepgo   + /// 
	fpigsgo    + /// 
	fpoultgo   + /// 
	fhorsego   + ///
	fothergo 
