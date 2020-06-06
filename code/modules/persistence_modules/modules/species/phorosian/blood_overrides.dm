/datum/reagent/blood/affect_touch(var/mob/living/carbon/M, var/alien, var/removed)
	if(data["species"] == SPECIES_PHOROSIAN)
		if(alien != IS_PHOROSIAN)
			M.apply_damage(removed * 0.1, BURN) //being splashed directly with phoron causes minor chemical burns
			if(prob(10 * 5))
				M.pl_effects()
	. = ..()

/datum/reagent/blood/touch_mob(var/mob/living/L, var/amount)
	if(data["species"] == SPECIES_PHOROSIAN)
		if(istype(L))
			L.adjust_fire_stacks(amount / 5)

/datum/reagent/blood/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	. = ..()
	if(data["species"] == SPECIES_PHOROSIAN)
		if(alien != IS_DIONA && alien != IS_PHOROSIAN)
			M.add_chemical_effect(CE_TOXIN, 30)
			var/dam = (30 * removed)
			if(dam)
				M.adjustToxLoss(null ? (dam * 0.75) : dam)
	