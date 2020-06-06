/datum/gas_mixture/after_load()
	for(var/x in gas)
		var/val = gas[x]
		if(val < 0.01) //Clear gases that have a reaaally low mole count, so we're not stuck with all that useless clutter
			gas -= x
	..()
/datum/gas_mixture/heat_capacity()
	if(isnull(gas_data))
		log_debug("gas_mixture.heat_capacity() : gas_data is null! We tried to get gas data before the list was generated!")
		return 0
	. = ..()