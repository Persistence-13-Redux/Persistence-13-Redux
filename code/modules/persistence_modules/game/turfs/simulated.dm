/turf/simulated/New()
	..()
	ADD_SAVED_VAR(wet)
	ADD_SAVED_VAR(dirt)
	ADD_SAVED_VAR(has_resources)
	ADD_SAVED_VAR(resources)

/turf/simulated/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/turf/simulated/LateInitialize()
	. = ..()
	if(map_storage_loaded && wet)
		wet_floor(wet)
	levelupdate()

/turf/simulated/Destroy()
	deltimer(timer_id)
	return ..()
