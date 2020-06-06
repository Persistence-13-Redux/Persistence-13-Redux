/mob/living/carbon/New()
	..()
	ADD_SAVED_VAR(immunity) //defined in viruses.dm
	ADD_SAVED_VAR(saved_species)
	ADD_SAVED_VAR(virus2)
	ADD_SAVED_VAR(antibodies)
	ADD_SAVED_VAR(handcuffed)
	ADD_SAVED_VAR(surgeries_in_progress)
	ADD_SAVED_VAR(touching)
	ADD_SAVED_VAR(nutrition)
	ADD_SAVED_VAR(internal_organs_by_name) //Save only organs by name, since we don't want useless duplicate lists of organs
	ADD_SAVED_VAR(organs_by_name)
	ADD_SAVED_VAR(losebreath)

	ADD_SKIP_EMPTY(saved_species)
	ADD_SKIP_EMPTY(virus2)
	ADD_SKIP_EMPTY(antibodies)
	ADD_SKIP_EMPTY(handcuffed)
	ADD_SKIP_EMPTY(surgeries_in_progress)
	ADD_SKIP_EMPTY(internal_organs_by_name)
	ADD_SKIP_EMPTY(organs_by_name)

/mob/living/carbon/Initialize()
	. = ..()
	if(!map_storage_loaded)
		//setup reagent holders
		bloodstr = new/datum/reagents/metabolism(120, src, CHEM_BLOOD)
		touching = new/datum/reagents/metabolism(1000, src, CHEM_TOUCH)
		reagents = bloodstr

/mob/living/carbon/Destroy(var/clearlace = FALSE)
	//Drop the lace
#ifndef UNIT_TEST
	if(LAZYLEN(internal_organs_by_name))
		var/obj/item/organ/internal/stack/lace = internal_organs_by_name[BP_STACK]
		if(clearlace || !istype(lace))
			qdel(lace, clearlace, clearlace) //Die stack :D
		else
			lace.removed(dolace = !clearlace)
			lace.dropInto(get_turf(src))
#endif
	return ..()

/mob/living/carbon/after_load()
	. = ..()
	bloodstr = reagents //Since reagents is saved, but not bloodstream
	//Rebuild organ list, from saved organs
	organs = list()
	internal_organs = list()
	for(var/name in organs_by_name)
		organs |= organs_by_name[name]
	for(var/name in internal_organs_by_name)
		internal_organs |= internal_organs_by_name[name]
	var/sname = custom_saved_vars["specie_name"]
	species = sname? all_species[sname] : null
	

/mob/living/carbon/human/before_save()
	. = ..()
	//Put the specie name as species type during saving
	custom_saved_vars["specie_name"] = species?.name
