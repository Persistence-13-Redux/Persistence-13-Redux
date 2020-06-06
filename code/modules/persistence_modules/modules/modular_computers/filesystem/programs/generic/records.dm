/datum/nano_module/records/proc/get_connected_faction()
	if(host)
		var/atom/movable/AM = host
		if(AM)
			return AM.get_faction()
	return null
