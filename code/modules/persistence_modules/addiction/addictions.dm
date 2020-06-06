/mob/living/carbon/
	var/datum/metabolism_effects/metabolism_effects = null

/mob/living/carbon/New()
	. = ..()
	ADD_SAVED_VAR(metabolism_effects)

/mob/living/carbon/Initialize()
	. = ..()
	if(!map_storage_loaded)
		metabolism_effects = new/datum/metabolism_effects(src)

/mob/living/carbon/Destroy(clearlace)
	. = ..()
	QDEL_NULL(metabolism_effects)

/mob/living/carbon/rejuvenate()
	. = ..()
	metabolism_effects.clear_effects()

/mob/living/carbon/brain/handle_chemicals_in_body()
	metabolism_effects.process()
	. = ..()

/mob/living/carbon/human/handle_chemicals_in_body()

	chem_effects.Cut()

	if(status_flags & GODMODE)
		return 0

	if(isSynthetic())
		return

	if(reagents)
		if(metabolism_effects && config.addiction) metabolism_effects.process()
	. = ..()
