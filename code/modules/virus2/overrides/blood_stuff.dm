//
// Blood stuff
//
/mob/living/carbon/inject_blood(var/datum/reagent/blood/injected, var/amount)
	if (!injected || !istype(injected))
		return
	var/list/sniffles = virus_copylist(injected.data["virus2"])
	for(var/ID in sniffles)
		var/datum/disease2/disease/sniffle = sniffles[ID]
		infect_virus2(src,sniffle,1)
	if (injected.data["antibodies"] && prob(5))
		antibodies |= injected.data["antibodies"]
	return ..()

/mob/living/carbon/get_blood_data()
	var/data = ..()
	if (!data["virus2"])
		data["virus2"] = list()
	data["virus2"] |= virus_copylist(virus2)
	data["antibodies"] = antibodies
	return data


/mob/living/carbon/human/proc/cure_virus(var/virus_uuid)
	if(vessel && virus_uuid)
		for(var/datum/reagent/blood/B in vessel.reagent_list)
			var/list/viruses = list()
			viruses = B.data["virus2"]
			viruses.Remove("[virus_uuid]")
			B.data["virus2"] = viruses


/mob/living/carbon/human/fixblood()
	. = ..()
	for(var/datum/reagent/blood/B in vessel.reagent_list)
		if(istype(B))
			B.data["virus2"] = list()
			B.data["antibodies"] = list()
