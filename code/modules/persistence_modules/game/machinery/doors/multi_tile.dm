/obj/vis_blocker
	mouse_opacity = 0
	should_save = 0
	opacity = 1
	anchored = 1

/obj/machinery/door/airlock/multi_tile
	icon_state = "closed"
	var/obj/vis_blocker/blocker

/obj/machinery/door/airlock/multi_tile/Destroy()
	QDEL_NULL(blocker)
	return ..()

/obj/machinery/door/airlock/multi_tile/after_load()
	SetBounds()
	..()

/obj/machinery/door/airlock/multi_tile/should_save(var/datum/caller)
	if(caller == loc)
		return ..()
	else
		return 0
	return ..()

/obj/machinery/door/airlock/multi_tile/Initialize(mapload)
	. = ..()
	if(mapload)
		queue_icon_update()
	else
		update_icon()
	SetBounds()

/obj/machinery/door/airlock/multi_tile/SetBounds()
	. = ..()
	if(opacity)
		for(var/turf/T in locs)
			if(T != loc)
				if(blocker)
					qdel(blocker)
				blocker = new(T)

/obj/machinery/door/airlock/multi_tile/on_update_icon(state=0, override=0)
	var/old_dir = dir
	..()
	set_dir(old_dir) //The base proc does some  stupid things to turn the door to walls, but we reaaaally don't want that happening on multi-tile doors

	//Since some of the icons are off-center, we have to align them for now
	// Would tweak the icons themselves, but dm is currently crashing when trying to edit icons at all!
	switch(dir)
		if(NORTH)
			pixel_y = -32
			pixel_x = 0
		if(SOUTH)
			pixel_y = 0
			pixel_x = 0
		if(EAST)
			pixel_y = 0
			pixel_x = -32
		if(WEST)
			pixel_y = 0
			pixel_x = 0
	
	SetBounds() //Lets just be sure

/obj/machinery/door/airlock/multi_tile/command
	req_access = list(core_access_command_programs)

/obj/machinery/door/airlock/multi_tile/security
	req_access = list(core_access_security_programs)

/obj/machinery/door/airlock/multi_tile/engineering
	req_access = list(core_access_engineering_programs)

/obj/machinery/door/airlock/multi_tile/medical
	req_access = list(core_access_medical_programs)

/obj/machinery/door/airlock/multi_tile/virology
	req_access = list(core_access_medical_programs)

/obj/machinery/door/airlock/multi_tile/atmos
	req_access = list(core_access_engineering_programs)

/obj/machinery/door/airlock/multi_tile/research
	req_access = list(core_access_science_programs)

/obj/machinery/door/airlock/multi_tile/science
	req_access = list(core_access_science_programs)

/obj/machinery/door/airlock/multi_tile/sol
	req_access = list(core_access_command_programs)

/obj/machinery/door/airlock/multi_tile/maintenance
	req_access = list(core_access_engineering_programs)

/obj/machinery/door/airlock/multi_tile/glass
	glass = TRUE
	opacity = FALSE
	maxhealth = 600

/obj/machinery/door/airlock/multi_tile/glass/command
	req_access = list(core_access_command_programs)

/obj/machinery/door/airlock/multi_tile/glass/security
	req_access = list(core_access_security_programs)

/obj/machinery/door/airlock/multi_tile/glass/engineering
	req_access = list(core_access_engineering_programs)

/obj/machinery/door/airlock/multi_tile/glass/medical
	req_access = list(core_access_medical_programs)

/obj/machinery/door/airlock/multi_tile/glass/virology
	req_access = list(core_access_medical_programs)

/obj/machinery/door/airlock/multi_tile/glass/atmos
	req_access = list(core_access_engineering_programs)

/obj/machinery/door/airlock/multi_tile/glass/research
	req_access = list(core_access_science_programs)

/obj/machinery/door/airlock/multi_tile/glass/science
	req_access = list(core_access_science_programs)

/obj/machinery/door/airlock/multi_tile/glass/sol
	req_access = list(core_access_command_programs)

/obj/machinery/door/airlock/multi_tile/glass/maintenance
	req_access = list(core_access_engineering_programs)
