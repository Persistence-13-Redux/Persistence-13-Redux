/mob/living/carbon/
	var/list/datum/disease2/disease/virus2 = list()
	var/list/antibodies = list()

/mob/living/carbon/Bump(var/atom/movable/AM, yes)
	if(now_pushing || !yes)
		return
	..()
	if(istype(AM, /mob/living/carbon) && prob(10))
		src.spread_disease_to(AM, "Contact")

/mob/living/carbon/handle_viruses()
	if(status_flags & GODMODE)	return 0	//godmode

	if(bodytemperature > 406)
		for (var/ID in virus2)
			var/datum/disease2/disease/V = virus2[ID]
			V.cure(src)

	if(life_tick % 3) //don't spam checks over all objects in view every tick.
		for(var/obj/effect/decal/cleanable/O in view(1,src))
			if(istype(O,/obj/effect/decal/cleanable/blood))
				var/obj/effect/decal/cleanable/blood/B = O
				if(isnull(B.virus2))
					B.virus2 = list()
				if(B.virus2.len)
					for (var/ID in B.virus2)
						var/datum/disease2/disease/V = B.virus2[ID]
						infect_virus2(src,V)

			else if(istype(O,/obj/effect/decal/cleanable/mucus))
				var/obj/effect/decal/cleanable/mucus/M = O
				if(isnull(M.virus2))
					M.virus2 = list()
				if(M.virus2.len)
					for (var/ID in M.virus2)
						var/datum/disease2/disease/V = M.virus2[ID]
						infect_virus2(src,V)

	if(virus2.len)
		for (var/ID in virus2)
			var/datum/disease2/disease/V = virus2[ID]
			if(isnull(V)) // Trying to figure out a runtime error that keeps repeating
				CRASH("virus2 nulled before calling activate()")
			else
				V.process(src)
			// activate may have deleted the virus
			if(!V) continue

			// check if we're immune
			var/list/common_antibodies = V.antigen & src.antibodies
			if(common_antibodies.len)
				V.dead = 1

	if(immunity > 0.2 * immunity_norm && immunity < immunity_norm)
		immunity = min(immunity + 0.25, immunity_norm)

	if(life_tick % 5 && immunity < 15 && chem_effects[CE_ANTIVIRAL] < VIRUS_COMMON && !virus2.len)
		var/infection_prob = 15 - immunity
		var/turf/simulated/T = loc
		if(istype(T))
			infection_prob += T.dirt
		if(prob(infection_prob))
			infect_mob_random_lesser(src)

//
//	Humans
//
/mob/living/carbon/human/revive()
	. = ..()
	for (var/ID in virus2)
		var/datum/disease2/disease/V = virus2[ID]
		V.cure(src)

/mob/living/carbon/human/attack_hand(mob/living/carbon/M as mob)
	. = ..()
	if(istype(M,/mob/living/carbon))
		M.spread_disease_to(src, "Contact")

/mob/living/carbon/human/handle_post_breath(datum/gas_mixture/breath)
	..()
	//spread some viruses while we are at it
	if(breath && !internal && virus2.len > 0 && prob(10))
		for(var/mob/living/carbon/M in view(1,src))
			src.spread_disease_to(M)

/mob/living/carbon/human/handle_hud_list()
	. = ..()
	if (BITTEST(hud_updateflag, STATUS_HUD) && hud_list[STATUS_HUD] && hud_list[STATUS_HUD_OOC])
		var/foundVirus = 0
		for (var/ID in virus2)
			if (ID in virusDB)
				foundVirus = 1
				break
		var/image/holder = hud_list[STATUS_HUD]
		if(stat != DEAD && foundVirus)
			holder.icon_state = "hudill"

		var/image/holder2 = hud_list[STATUS_HUD_OOC]
		if(stat != DEAD && !has_brain_worms() && virus2.len)
			holder2.icon_state = "hudill"



