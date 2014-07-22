local startdir: pwd

cd "D:\Data\data_NFSPanelAnalysis\OrigData\RAW_79_83\"

local YY = 79
while `YY' < 84{
	local i = 1
	while `i' < 71 {
		di "Doing convertSheet`i'.do (year = `YY')..."
		qui do sub_do/convertSheet`i'.do standalone `YY'
		di "convertSheet`i'.do completed without error."

		foreach letter in N  W  I  J  K  L  M {
		 
			 di "Looking for column `letter'"
			 			 
			 quietly{
				
						novarabbrev {
							capture confirm variable `letter'
						}

			 
						if _rc == 0 {
					
							di "Found column `letter' in Sheet`i'"
							describe, short
							local troubled "`troubled' `YY'_`i':`letter'"
						* end if _rc
						}
				* end quietly
				}					
				
				
		
		} 
		
		local i = `i' + 1
	}
	
	local YY = `YY' + 1
	
}

foreach entry of local troubled{
	di "`entry'"
}
cd `startdir'
