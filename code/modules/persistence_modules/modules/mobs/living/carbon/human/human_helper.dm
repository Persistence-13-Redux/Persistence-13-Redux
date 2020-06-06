/mob/living/carbon/human/fully_replace_character_name(var/new_name, var/in_depth = TRUE)
	var/old_name = src.real_name
	. = ..()
	var/datum/character_records/CR = GetCharacterRecord(old_name)
	if(CR)
		CR.set_real_name(new_name)
	//Rename all owned ids
	for(var/obj/item/weapon/card/id/ID in GLOB.all_id_cards)
		if(ID.registered_name == old_name)
			ID.registered_name = new_name
			ID.update_name()
			if(istype(ID.loc, /obj/item/modular_computer/pda))
				var/obj/item/modular_computer/pda/PDA = ID?.loc?.loc
				if(PDA)
					PDA.update_name()

// /mob/living/carbon/human/reset_layer()
// 	if(riding)
// 		layer = VEHICLE_LOAD_LAYER
// 	else
// 		return ..()