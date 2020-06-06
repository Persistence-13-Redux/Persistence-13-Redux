
/obj/machinery/power/terminal/Initialize()
	..()
	if(!loc)
		return INITIALIZE_HINT_QDEL
	var/turf/T = get_turf(src)
	if(level==1) hide(!T.is_plating())
	return

