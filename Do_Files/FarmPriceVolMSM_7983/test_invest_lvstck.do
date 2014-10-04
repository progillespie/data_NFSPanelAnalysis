* Original Data
local OrigData ///
  "D:\DATA\Data_NFSPanelANalysis\OutData\RAW_79_83\svy_tables_7983"

	******************************************************
	* Investment in livestock
	******************************************************
        clear

        local svy_tables "`svy_tables' cattle"
        local svy_tables "`svy_tables' sheep"
        local svy_tables "`svy_tables' pigs"
        local svy_tables "`svy_tables' poultry"
        *local svy_tables "`svy_tables' horses" // off for 79-83

        foreach table of local svy_tables {

          qui count
          if `r(N)' == 0  use "`OrigData'\svy_`table'.dta", clear
	  else merge 1:1 FARM_CODE YE_AR using ///
                 `OrigData'/svy_`table', nogen    

        }

        gen double d_investment_in_livestock = 0
        replace d_investment_in_livestock =  ///
          (d_op_inv_dairy_herd_eu             + /// 
           d_clos_inv_dairy_herd_eu           + /// 
           d_opening_inventory_cattle_herd_eu + /// 
           d_closing_inventory_cattle_herd_eu + /// 
           d_opening_inventory_sheep_flock_eu + /// 
           d_closing_inventory_sheep_flock_eu + /// 
           d_opening_inventory_pigs_eu        + /// 
           d_closing_inventory_pigs_eu        + /// 
           d_opening_inventory_poultry_eu     + /// 
           d_closing_inventory_poultry_eu     + /// 
           d_opening_inventory_horses_eu      + /// 
           d_closing_inventory_horses_eu      + /// 
           d_deer_op_inv_eu                   + /// 
           d_deer_clos_inv_eu) / 2


        tabstat                             /// 
           d_investment_in_livestock           ///
           d_op_inv_dairy_herd_eu              /// 
           d_clos_inv_dairy_herd_eu            /// 
           d_opening_inventory_cattle_herd_eu  /// 
           d_closing_inventory_cattle_herd_eu  /// 
           d_opening_inventory_sheep_flock_eu  /// 
           d_closing_inventory_sheep_flock_eu  /// 
           d_opening_inventory_pigs_eu         /// 
           d_closing_inventory_pigs_eu         /// 
           d_opening_inventory_poultry_eu      /// 
           d_closing_inventory_poultry_eu      /// 
           d_opening_inventory_horses_eu       /// 
           d_closing_inventory_horses_eu       /// 
           d_deer_op_inv_eu                    /// 
           d_deer_clos_inv_eu 

