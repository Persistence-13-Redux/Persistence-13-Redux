var/const/ATM_RG = 9	//Reagent Gases

// /proc/mode_to_gasid(var/mode)
// 	switch(mode)
// 		if(ATM_O2)
// 			return list(GAS_OXYGEN)
// 		if(ATM_N2)
// 			return list(GAS_NITROGEN)
// 		if(ATM_CO2)
// 			return list(GAS_CO2)
// 		if(ATM_P)
// 			return list(GAS_PHORON)
// 		if(ATM_N2O)
// 			return list(GAS_N2O)
// 		if(ATM_H2)
// 			return list(GAS_HYDROGEN)
// 		if(ATM_RG)
// 			var/list/reagent_gases_list = list()
// 			for(var/g in gas_data.gases) //This only fires when initially selecting the filter type, so impact on performance is minimal
// 				if(gas_data.flags[g] & XGM_GAS_REAGENT_GAS)
// 					reagent_gases_list += g
// 			return reagent_gases_list
// 		else
// 			return null