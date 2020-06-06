/atom/movable/proc/get_faction()
	var/obj/item/weapon/card/id/id = GetIdCard()
	return id ? id.get_faction() : null

/atom/movable/proc/get_faction_uid()
	var/obj/item/weapon/card/id/id = GetIdCard()
	return id ? id.get_faction_uid() : null

/atom/movable/allowed(mob/M)
	//check if it doesn't require any access at all
	if(src.check_access(null))
		return TRUE
	if(!istype(M))
		return FALSE
	if(!get_faction())
		return check_access_list(M.GetAccess())
	else if(M.get_faction() == get_faction())
		return check_access_list(M.GetAccess())
	else
		return FALSE

/atom/movable/Destroy()
	if(LAZYLEN(movement_handlers) && !ispath(movement_handlers[1]))
		QDEL_NULL_LIST(movement_handlers)

	if (bound_overlay)
		QDEL_NULL(bound_overlay)

	if(virtual_mob && !ispath(virtual_mob))
		qdel(virtual_mob)
		virtual_mob = null
	. = ..()

//Called by a weapon's "afterattack" proc when an attack has succeeded. Returns blocked damage
/atom/movable/proc/hit_with_weapon(obj/item/I, mob/living/user, var/effective_force)
	visible_message(SPAN_DANGER("[src] has been [I.attack_verb.len? pick(I.attack_verb) : "attacked"] with [I.name] by [user]!"))
	return 0
/*
/atom/movable/touch_map_edge()
	var/new_x = x
	var/new_y = y
	var/new_z = z
	if(new_z)
		if(x <= TRANSITIONEDGE-1) 						// West
			new_x = TRANSITIONEDGE + 1
			var/datum/zlevel_data/data = SSmazemap.map_data["[z]"]
			if(data && data.W_connect)
				new_z = data.W_connect
				new_x = world.maxx - TRANSITIONEDGE - 1
		else if (x >= (world.maxx + 1 - TRANSITIONEDGE))	// East
			new_x = world.maxx - TRANSITIONEDGE - 1
			var/datum/zlevel_data/data = SSmazemap.map_data["[z]"]
			if(data && data.E_connect)
				new_x = TRANSITIONEDGE + 1
				new_z = data.E_connect

		else if (y <= TRANSITIONEDGE-1) 					// South
			new_y = TRANSITIONEDGE + 1
			var/datum/zlevel_data/data = SSmazemap.map_data["[z]"]
			if(data && data.S_connect)
				new_z = data.S_connect
				new_y = world.maxy - TRANSITIONEDGE - 1
		else if (y >= (world.maxy + 1 - TRANSITIONEDGE))	// North
			new_y = world.maxy - TRANSITIONEDGE - 1
			var/datum/zlevel_data/data = SSmazemap.map_data["[z]"]
			if(data && data.N_connect)
				new_z = data.N_connect
				new_y = TRANSITIONEDGE + 1
		var/turf/T = locate(new_x, new_y, new_z)
		if(T)
			forceMove(T)
			*/

/**
/atom/movable/proc/touch_map_edge()
	if(!simulated)
		return

	if(!z || (z in GLOB.using_map.sealed_levels))
		return

	if(!GLOB.universe.OnTouchMapEdge(src))
		return

	if(GLOB.using_map.use_overmap)
		overmap_spacetravel(get_turf(src), src)
		return

	#define worldWidth 5
	#define worldLength 5
	#define worldHeight 2

	var/new_x = x
	var/new_y = y
	var/new_z = z
	if(new_z)
		if(x <= TRANSITIONEDGE) 						// West
			new_x = world.maxx - TRANSITIONEDGE - 1
			new_z -= worldHeight
			if(new_z % (worldHeight * worldWidth) <= 0 || new_z % (worldHeight * worldWidth) > (worldWidth - 1) * worldHeight)
				new_z += worldWidth * worldHeight

		else if (x >= (world.maxx - TRANSITIONEDGE))	// East
			new_x = TRANSITIONEDGE + 1
			new_z += worldHeight
			if(new_z % (worldHeight * worldWidth) != 0 && new_z % (worldHeight * worldWidth) <= worldHeight)
				new_z -= worldWidth * worldHeight

		else if (y <= TRANSITIONEDGE) 					// South
			new_y = world.maxy - TRANSITIONEDGE - 1
			new_z -= worldWidth * worldHeight
			if(new_z <= 0)
				new_z += worldWidth * worldHeight * worldLength

		else if (y >= (world.maxy - TRANSITIONEDGE))	// North
			new_y = TRANSITIONEDGE + 1
			new_z += worldWidth * worldHeight
			if(new_z > worldWidth * worldHeight * worldLength)
				new_z -= worldWidth * worldHeight * worldLength

		var/turf/T = locate(new_x, new_y, new_z)
		if(T)
			forceMove(T)

#undef worldWidth
#undef worldLength
#undef worldHeight
*/