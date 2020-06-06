/obj/structure/cable/after_load()
	. = ..()
	icon_state = "[d1]-[d2]"
	
	var/turf/T = src.loc			// hide if turf is not intact
	if(T)
		if(level==1) hide(!T.is_plating())
	mergeConnectedNetworks(d1)
	mergeConnectedNetworks(d2)
