/datum/nano_module/proc/get_faction()
	if(istype(host, /atom/movable))
		var/atom/movable/AM = host
		return AM.get_faction()
	return null

/datum/nano_module/check_access(var/mob/user, var/access, var/faction_uid = null)
	if(get_faction())
		if(get_faction() != faction_uid)
			return FALSE
	return ..()
