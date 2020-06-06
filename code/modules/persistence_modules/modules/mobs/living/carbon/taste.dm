/mob/living/carbon/get_fullness()
	if(src.species && !(src.species.species_flags & SPECIES_FLAG_NO_HUNGER))
		return 400
	return ..()
