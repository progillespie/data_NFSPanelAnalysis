local lvar1 = "$var1"

*Following links NFS variable to price index variable

*Output vars
************


if "`lvar1'" == "WHLE_MILK_SOLD_TO_CREAMERY" {

global var2 = "PMilk"

}

if "`lvar1'" == "LQDMLK_SOLD_WSALE_RETAIL" {

global var2 = "PMilk"

}
 


if "`lvar1'" == "DAIRY_CALVES_TRANSFER" {

global var2 = "PCalves"

}


if "`lvar1'" == "DAIRY_CALVES_SALES" {

global var2 = "PCalves"

}


if "`lvar1'" == "DY_COWS_SH_BULS_TRNSFR_OUT" {

global var2 = "POtherCattle"

}



if "`lvar1'" == "DY_COWS_SH_BULLS_PURCHASES" {

global var2 = "POtherCattle"

}



if "`lvar1'" == "DY_COWS_SH_BULS_TRNSFR_IN" {

global var2 = "POtherCattle"

}


if "`lvar1'" == "CATTLE_WEANLINGS_SALES" {

global var2 = "POtherCattle"

}


if "`lvar1'" == "CATTLE_STORES_MALE_SALES" {

global var2 = "PStoreCattle"

}

if "`lvar1'" == "CATTLE_STORES_FEMALE_SALES" {

global var2 = "PStoreCattle"

}

if "`lvar1'" == "CATTLE_FINISHED_MALE_SALES" {

global var2 = "PPrimeCattle"

}

if "`lvar1'" == "CTL_FINISHED_FEMALE_SALES" {

global var2 = "PPrimeCattle"

}



if "`lvar1'" == "CTL_BREEDING_ANIMALS_SALES" {

global var2 = "POtherCattle"

}



if "`lvar1'" == "CATTLE_OTHER_SALES" {

global var2 = "POtherCattle"

}


if "`lvar1'" == "CTL_BREDING_HRD_CULS_SALES" {

global var2 = "PCowSlaughter"

}
  

if "`lvar1'" == "CATTLE_CALVES_PURCHASES" {

global var2 = "PCalves"

}


if "`lvar1'" == "CATTLE_CALVES_SALES" {

global var2 = "PCalves"

}


if "`lvar1'" == "CATTLE_WEANLINGS_PURCHASES" {

global var2 = "POtherCattle"

}


if "`lvar1'" == "CTL_STORES_MALE_PURCHASES" {

global var2 = "PStoreCattle"

}


if "`lvar1'" == "CTL_STORES_FMALE_PURCHASES" {

global var2 = "PStoreCattle"

}



if "`lvar1'" == "CTL_BREED_REPLCMENTS_PURCH" {

global var2 = "POtherCattle"

}


if "`lvar1'" == "CATTLE_OTHER_PURCHASES" {

global var2 = "POtherCattle"

}


if "`lvar1'" == "FAT_LAMBS_SALES" {

global var2 = "PSheep"

}

if "`lvar1'" == "STORE_LAMBS_SALES" {

global var2 = "PSheep"

}

if "`lvar1'" == "FAT_HOGGETS_SALES" {

global var2 = "PSheep"

}

if "`lvar1'" == "BREEDING_HOGGETS_SALES" {

global var2 = "PSheep"

}

if "`lvar1'" == "CULL_EWES_RAMS_SALES" {

global var2 = "PSheep"

}

if "`lvar1'" == "BREEDING_EWES_SALES" {

global var2 = "PSheep"

}

if "`lvar1'" == "USED_IN_HOUSE" {

global var2 = "PSheep"

}

if "`lvar1'" == "STORE_LAMBS_PURCHASES" {

global var2 = "PSheep"

}

if "`lvar1'" == "EWES_RAMS_PURCHASES" {

global var2 = "PSheep"

}

if "`lvar1'" == "BREEDING_HOGGETS_PURCHASES" {

global var2 = "PSheep"

}

     
*CROPS - Control for the crop codes below in the changeprice_cereals.do file
* var2 = "PCereals" if cropcode = SB 1141 WB 1146 SMB 1571 WMB 1576 SW 1111 WW 1116 SO 1151 WO 1156 
* var2 = "PSugarBeet" if cropcode = 1321
* var2 = "PPotatoes" if cropcode = 1311
*CY_SALES 
*CY_FED 


if "`lvar1'" == "CY_SALES" | "`lvar1'" == "CY_FED" {

global var2 = "PCereals" 

}



*Dont have an equivelent cso index var for the following NFS Output vars
************************************************************************
*DAIRY_CALVES_TRANSFER_EU 
*DAIRY_CALVES_SALES_EU
*DAIRY_COWS_SH_BULS_TRNSFR_OUT_EU
*DAIRY_COWS_SH_BULLS_PURCHASES_EU
*DAIRY_COWS_SH_BULS_TRNSFR_IN_EU
*CATTLE_WEANLINGS_SALES_EU
*CATTLE_BREEDING_ANIMALS_SALES_EU
*CATTLE_OTHER_SALES_EU
*CATTLE_CALVES_PURCHASES_EU
*CATTLE_WEANLINGS_PURCHASES_EU
*CATTLE_BREED_REPLACEMENTS_PURCHASES_EU
*CATTLE_OTHER_PURCHASES_EU
*CY_CLOSING 



*Input vars
***********


if "`lvar1'" == "CONC_ALLC_DARY_HRD_50KGBGS" {

global var2 = "PCattleFeed"

}

if "`lvar1'" == "CONC_ALLOC_CATTLE_50KGBAGS" {

global var2 = "PCattleFeed"

}

if "`lvar1'" == "CONC_ALLOC_SHEEP_50KGBAGS" {

global var2 = "PCattleFeed"

}


if "`lvar1'" == "CONC_ALLOC_HORSES_50KGBAGS" {

global var2 = "PAllFeed"

}


if "`lvar1'" == "CONC_ALLOC_PIGS_50KGBAGS" {

global var2 = "PPigFeed"

}

if "`lvar1'" == "CONC_ALLOC_PLTRY_50KGBAGS" {

global var2 = "PPoultryFeed"

}


if "`lvar1'" == "s_b_ALLOC_DAIRY_HERD" {

global var2 = "PAllFeed"

}


if "`lvar1'" == "s_b_ALLOC_CATTLE" {

global var2 = "PAllFeed"

}


if "`lvar1'" == "s_b_ALLOC_SHEEP" {

global var2 = "PAllFeed"

}


if "`lvar1'" == "s_b_ALLOC_HORSES" {

global var2 = "PAllFeed"

}


if "`lvar1'" == "s_b_ALLOC_DEER" {

global var2 = "PAllFeed"

}


if "`lvar1'" == "s_b_ALLOC_GOATS" {

global var2 = "PAllFeed"

}


if "`lvar1'" == "pfert" {

global var2 = "PTotalFert"

}


if "`lvar1'" == "CROP_PROTECTION" {

global var2 = "PPlantProtection"

}


if "`lvar1'" == "PURCHASED_SEED" {

global var2 = "PSeeds"

}


if "`lvar1'" == "TRANSPORT_GROSS_COST" {

global var2 = "CPI_Transport"

}


if "`lvar1'" == "TRANSPORT_SUBSIDY" {

global var2 = "CPI_Transport"

}


if "`lvar1'" == "MACHINERY_HIRE" {

global var2 = "POtherInputs"

}


if "`lvar1'" == "MISCELLANEOUS" {

global var2 = "POtherInputs"

}


if "`lvar1'" == "TRANSPORT_ALLOC_DAIRY_HERD" {

global var2 = "PMotorFuels"

}

if "`lvar1'" == "TRANSPORT_ALLOC_CATTLE" {

global var2 = "PMotorFuels"

}

if "`lvar1'" == "TRANSPORT_ALLOC_SHEEP" {

global var2 = "PMotorFuels"

}


if "`lvar1'" == "TRANSPORT_ALLOC_HORSES " {

global var2 = "PMotorFuels"

}

if "`lvar1'" == "TRANSPORT_ALLOC_PIGS" {

global var2 = "PMotorFuels"

}

if "`lvar1'" == "TRANSPORT_ALLOC_POULTRY" {

global var2 = "PMotorFuels"

}


if "`lvar1'" == "VET_MED_ALLOC_DAIRY_HERD" {

global var2 = "PVetExp"

}

if "`lvar1'" == "VET_MED_ALLOC_CATTLE" {

global var2 = "PVetExp"

}


if "`lvar1'" == "VET_MED_ALLOC_SHEEP" {

global var2 = "PVetExp"

}


if "`lvar1'" == "VET_MED_ALLOC_HORSES" {

global var2 = "PVetExp"

}


if "`lvar1'" == "VET_MED_ALLOC_PIGS" {

global var2 = "PVetExp"

}


if "`lvar1'" == "VET_MED_ETC_ALLOC_POULTRY" {

global var2 = "PVetExp"

}


if "`lvar1'" == "AI_SR_FEES_ALOC_DAIRY_HRD" {

global var2 = "PVetExp"

}    


if "`lvar1'" == "AI_SER_FEES_ALLOC_CATTLE" {

global var2 = "PVetExp"

}    


if "`lvar1'" == "AI_SER_FEES_ALLOC_SHEEP" {

global var2 = "PVetExp"

}    


if "`lvar1'" == "AI_SER_FEES_ALLOC_HORSES" {

global var2 = "PVetExp"

}    


if "`lvar1'" == "AI_SER_FEES_ALLOC_PIGS" {

global var2 = "PVetExp"

}    


if "`lvar1'" == "MISC_ALLOC_DAIRY_HERD" {

global var2 = "POtherInputs"

}


if "`lvar1'" == "MISCELLANEOUS_ALLOC_CATTLE" {

global var2 = "POtherInputs"

}    


if "`lvar1'" == "MISCELLANEOUS_ALLOC_SHEEP" {

global var2 = "POtherInputs"

}    


if "`lvar1'" == "MISCELLANEOUS_ALLOC_HORSES" {

global var2 = "POtherInputs"

}    


if "`lvar1'" == "MISCELLANEOUS_ALLOC_PIGS" {

global var2 = "POtherInputs"

}    


if "`lvar1'" == "MISC_ALLOC_POULTRY" {

global var2 = "POtherInputs"

}    



*Dont have an equivelent cso index var for the following NFS Input vars
************************************************************************
*CONC_ALLOC_HORSES_50KGBAGS_EU
*CONC_ALLOC_DEER_50KGBAGS_EU
*CONC_ALLOC_GOATS_50KGBAGS_EU
*BULKYFEED_COST_EU (by bulkyfeed code)
*TRANSPORT_GROSS_COST_EU
*TRANSPORT_SUBSIDY_EU
*MACHINERY_HIRE_EU
*MISCELLANEOUS_EU

