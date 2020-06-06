//Things that shouldn't save can be listed here to avoid changing some of the original bay files and make merging easier.
/area/map_storage_saved_vars = ""
/area/after_load()
	power_change()
/area/proc/get_turfs()
	var/list/all_turfs = list()
	for(var/turf/T in src)
		all_turfs |= T
	return all_turfs