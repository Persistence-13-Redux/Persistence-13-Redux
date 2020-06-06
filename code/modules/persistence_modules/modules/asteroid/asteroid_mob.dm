// Code to allow asteroid mobs to attack some miner equipment.
/mob/living/simple_animal/hostile/asteroid
	faction = "asteroid"

	//All destroy things
	destroy_surroundings = TRUE

	//All immune to space
	min_gas = null
	max_gas = null
	minbodytemp = 0

/mob/living/simple_animal/hostile/asteroid/ListTargets(dist)
	var/list/possible_targets = ..()
	possible_targets += locate(/obj) in orange(dist,src)
	for(var/obj/O in possible_targets)
		if(!ValidTarget(O))
			possible_targets -= O
	return possible_targets

/mob/living/simple_animal/hostile/asteroid/ValidTarget(var/atom/movable/AM)
	. = ..()
	if(!.)
		return .
	if(istype(AM, /obj/machinery/mining/drill))
		var/obj/machinery/mining/drill/drill = AM
		if(drill.active)
			return TRUE
	if(istype(AM, /obj/structure/ore_box))
		var/obj/structure/ore_box/OB = AM
		if(length(OB.contents))
			return TRUE
	if(istype(AM, /obj/item/stack/ore))
		return TRUE
	return FALSE