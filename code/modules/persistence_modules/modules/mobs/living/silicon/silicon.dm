/mob/living/silicon/fully_replace_character_name(new_name)
	..()
	if(istype(idcard))
		idcard.update_name()