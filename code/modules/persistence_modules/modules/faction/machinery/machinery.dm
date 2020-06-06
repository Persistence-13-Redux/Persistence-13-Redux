/obj/machinery
	var/tmp/datum/world_faction/faction
	var/faction_uid

/obj/machinery/New()
	..()
	ADD_SAVED_VAR(faction_uid)

/obj/machinery/Initialize()
	. = ..()
	if(faction_uid && !faction)
		connect_faction(FindFaction(faction_uid))

/obj/machinery/Destroy()
	disconnect_faction()
	return ..()

//----------------------------------------
// Interactions
//----------------------------------------
/obj/machinery/proc/can_connect(var/datum/world_faction/trying)
	return 1

/obj/machinery/proc/connect_faction(var/datum/world_faction/F, var/mob/user)
	if(istext(F))
		F = FindFaction(F)
	if(istype(F) && can_connect(F))
		faction = F
		faction_uid = F.uid
		req_access_faction = faction_uid
		return TRUE
	return FALSE

/obj/machinery/proc/disconnect_faction(var/mob/user)
	faction = null
	faction_uid = null
	req_access_faction = null
	return TRUE

/obj/machinery/get_faction_uid()
	return faction_uid
/obj/machinery/get_faction()
	return faction

/obj/machinery/proc/can_disconnect(var/datum/world_faction/trying, var/mob/M)
	return 1