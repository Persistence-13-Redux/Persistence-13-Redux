/datum/reagent/nutriment/adjust_nutrition(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_RESOMI)
		if(nutriment_factor)
			M.adjust_nutrition(nutriment_factor * 0.8) // For hunger and fatness
		if(hydration_factor)
			M.adjust_hydration(hydration_factor * 0.8) // For thirst
		return
	return ..()

/datum/reagent/nutriment/protein/adjust_nutrition(var/mob/living/carbon/M, var/alien, var/removed)
	if(alien == IS_RESOMI)
		removed *= 1.25
		M.adjust_nutrition(nutriment_factor * removed)
		return
	. = ..()


