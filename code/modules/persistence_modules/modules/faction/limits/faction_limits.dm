/datum/world_faction
	var/datum/machine_limits/limits

/datum/world_faction/New()
	..()
	limits = new()

/datum/world_faction/proc/rebuild_limits()
	return

/datum/world_faction/proc/get_limits()
	return limits

//(Re)Calculates the current claimed area and returns it.
/datum/world_faction/proc/get_claimed_area()
	src.calculate_claimed_area()
	return limits.claimed_area

//Calculates the current claimed area. Only used by "get_claimed_area()" and "apc/can_disconnect()" procs.~
//Call "get_claimed_area()" directly instead (in most cases).
/datum/world_faction/proc/calculate_claimed_area()
	var/new_claimed_area = 0

	for(var/obj/machinery/power/apc/apc in limits.apcs)
		//if(!apc.area || apc.area.shuttle) continue
		if(!apc.area) continue
		var/list/apc_turfs = get_area_turfs(apc.area)
		new_claimed_area += apc_turfs.len
	limits.claimed_area = new_claimed_area