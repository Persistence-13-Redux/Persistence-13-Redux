/datum/pipeline/mingle_with_turf(turf/simulated/target, mingle_volume)
	if(!target) return
	. = ..()

/datum/pipeline/radiate_heat_to_space(surface, thermal_conductivity)
	if(isnull(air))
		return FALSE
	. = ..()
	return TRUE
