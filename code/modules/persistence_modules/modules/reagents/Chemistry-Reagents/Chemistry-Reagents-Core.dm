/datum/reagent/blood/New(datum/reagents/holder)
	data["donor_name"] = ""
	. = ..()

/datum/reagent/blood/before_save()
	. = ..()
	//Before saving remove the reference in the data to the donor.
	// Because weakrefs don't save, and blood is re-inited in mobs anyways
	if(data && istype(data["donor"], /weakref) )
		var/weakref/mobref = data["donor"]
		var/mob/living/carbon/human/donor = mobref.resolve()
		custom_saved_vars["donor_name"] = donor?.real_name
		data["donor"] = null

/datum/reagent/blood/after_save()
	. = ..()
	//After the save is done, put the donor back into the saved data
	if(custom_saved_vars["donor_name"])
		data["donor_name"] = custom_saved_vars["donor_name"]
		//data["donor"] = get_human_by_real_name(custom_saved_vars["donor_name"])

//Make it so the donor's mob is looked up only when needed!!
/datum/reagent/blood/proc/get_donor()
	var/mob/living/carbon/human/H = data["donor"]
	if(H)
		return H
	return data["donor_name"] ? (data["donor"] = get_human_by_real_name(data["donor_name"])) : null

/datum/reagent/blood/proc/get_dna()
	return data["blood_DNA"]

/datum/reagent/blood/proc/get_bloodtype()
	return data["blood_type"]

/datum/reagent/water
	gas_id = GAS_STEAM
/datum/reagent/fuel
	gas_flags = XGM_GAS_CONTAMINANT | XGM_GAS_FUEL | XGM_GAS_REAGENT_GAS