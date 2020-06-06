/mob/living/bot
	var/tmp/datum/world_faction/connected_faction
	var/connected_faction_uid

/mob/living/bot/New()
	..()
	ADD_SAVED_VAR(connected_faction_uid)

/mob/living/bot/Destroy()
	connected_faction = null
	return ..()

/mob/living/bot/after_load()
	..()
	connected_faction = FindFaction(connected_faction_uid)

/mob/living/bot/before_save()
	. = ..()
	if(istype(connected_faction))
		connected_faction_uid = connected_faction.uid

/mob/living/bot/proc/set_faction(var/F)
	if(istype(F, /datum/world_faction))
		connected_faction = F
		connected_faction_uid = connected_faction.uid
		return TRUE
	else if(istext(F))
		var/datum/world_faction/newfac = FindFaction(F)
		if(newfac)
			connected_faction_uid = F
			connected_faction = newfac
			return TRUE
	return FALSE

/mob/living/bot/get_faction()
	return connected_faction

/mob/living/bot/get_faction_uid()
	return connected_faction_uid

/mob/living/bot/attackby(var/obj/item/O, var/mob/user)
	if(O.GetIdCard())
		if(!connected_faction && O.get_faction())
			set_faction(O.get_faction())
			to_chat(user, SPAN_NOTICE("\The [src] has been synced to your faction"))
	return ..()
