/datum/xgm_gas_data
	//Ratio of the reagents that one mole of the gas is (molecularly) made of.
	var/list/component_reagents = list()

/decl/xgm_gas
	var/list/component_reagents

//Redefined to include creating the component reagents part
/hook/startup/generateGasData()
	gas_data = new
	for(var/p in (typesof(/decl/xgm_gas) - /decl/xgm_gas))
		var/decl/xgm_gas/gas = new p //avoid initial() because of potential New() actions

		if(gas.id in gas_data.gases)
			error("Duplicate gas id `[gas.id]` in `[p]`")

		gas_data.gases += gas.id
		gas_data.name[gas.id] = gas.name
		gas_data.specific_heat[gas.id] = gas.specific_heat
		gas_data.molar_mass[gas.id] = gas.molar_mass
		if(gas.overlay_limit)
			gas_data.overlay_limit[gas.id] = gas.overlay_limit
			gas_data.tile_overlay[gas.id] = gas.tile_overlay
			gas_data.tile_overlay_color[gas.id] = gas.tile_color
		gas_data.flags[gas.id] = gas.flags
		gas_data.burn_product[gas.id] = gas.burn_product

		gas_data.symbol_html[gas.id] = gas.symbol_html
		gas_data.symbol[gas.id] = gas.symbol

		if(!isnull(gas.condensation_product) && !isnull(gas.condensation_point))
			gas_data.condensation_points[gas.id] = gas.condensation_point
			gas_data.condensation_products[gas.id] = gas.condensation_product

		gas_data.breathed_product[gas.id] = gas.breathed_product
		gas_data.hidden_from_codex[gas.id] = gas.hidden_from_codex
		gas_data.component_reagents[gas.id] = gas.component_reagents
	return 1

//Make a gas type entry for each reagents we got, so we can refer to each of those at runtime before any of them is created by the sublimator
/hook/startup/proc/precacheReagentGasData()
	for(var/r in (typesof(/datum/reagent) - /datum/reagent))
		var/datum/reagent/reagent = new r
		var/gas_id = reagent.gas_id ? reagent.gas_id : lowertext(reagent.name)
		if(gas_id in gas_data.gases) //Prevents the creation of reagent gases that already exist IE: Phoron
			continue
		gas_data.gases +=                     gas_id					//Default values for reagent gases can be found in Chemistry-Reagents.dm
		gas_data.name[gas_id] =               reagent.name
		gas_data.specific_heat[gas_id] =      reagent.gas_specific_heat
		gas_data.molar_mass[gas_id] =         reagent.gas_molar_mass
		gas_data.overlay_limit[gas_id] =      reagent.gas_overlay_limit
		gas_data.flags[gas_id] =              reagent.gas_flags
		gas_data.burn_product[gas_id] =       reagent.gas_burn_product
		gas_data.component_reagents[gas_id] = list(reagent.type = 1)
		gas_data.condensation_points[gas_id] = reagent.heating_point
		gas_data.condensation_products[gas_id] = reagent.type
		qdel(reagent)
	return TRUE