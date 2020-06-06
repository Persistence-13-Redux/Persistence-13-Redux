/atom/hitby(atom/movable/AM, var/datum/thrownthing/TT)//already handled by throw impact
	if(isliving(AM))
		var/mob/living/M = AM
		var/obj/thing = TT.thrownthing
		M.apply_damage(TT.speed * TT.thrownthing.mass, thing? thing.damtype : BRUTE)

/mob/living/carbon/human/pl_effects()
	if(species == SPECIES_PHOROSIAN)
		return
	. = ..()
