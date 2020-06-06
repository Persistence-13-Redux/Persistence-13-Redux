
/obj/item/organ/external/update_wounds()
	. = ..()
	for(var/datum/wound/W in wounds)
		// Salving also helps against infection
		if(W.germ_level > 0 && W.salved && prob(2))
			W.disinfected = 1
			W.germ_level = 0