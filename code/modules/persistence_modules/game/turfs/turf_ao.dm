// /turf/Initialize(mapload)
// 	. = ..()
// 	if (map_storage_loaded && permit_ao)
// 		queue_ao()

/turf/set_density(var/new_density)
	var/last_density = density
	..()
	if(density != last_density && permit_ao)
		regenerate_ao()
