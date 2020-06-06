/obj/machinery/door
	atmos_canpass = CANPASS_PROC
	var/datum/gas_mixture/tile_air

/obj/machinery/door/before_save()
	if(loc && istype(loc, /turf/simulated))
		var/turf/simulated/floor = loc
		tile_air = floor.air
	..()

/obj/machinery/door/after_load()
	if(tile_air)
		for(var/turf/simulated/T in locs)
			T.air = new()
			T.air.copy_from(tile_air)

/obj/machinery/door/Bumped(atom/AM)
	if(p_open || operating) return
	. = ..()
	if(istype(AM, /obj/vehicle))
		var/obj/vehicle/V = AM
		if(density)
			if(V.buckled_mob && src.allowed(V.buckled_mob))
				open()
			else
				do_animate("deny")
		return

/obj/machinery/door/bumpopen(mob/user as mob)
	. = ..()
	update_icon()

/obj/machinery/door/on_update_icon()
	//Don't do that. It does weird shit with multi-tile doors and some wall placements, and its generally uneeded
	// if(connections in list(NORTH, SOUTH, NORTH|SOUTH))
	// 	if(connections in list(WEST, EAST, EAST|WEST))
	// 		set_dir(SOUTH)
	// 	else
	// 		set_dir(EAST)
	// else
	// 	set_dir(SOUTH)

	if(density)
		icon_state = "door1"
	else
		icon_state = "door0"
	SSradiation.resistance_cache.Remove(get_turf(src))
	return
