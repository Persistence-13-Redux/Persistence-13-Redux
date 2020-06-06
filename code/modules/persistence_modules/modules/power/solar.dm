/obj/machinery/power/solar/set_broken(new_state)
	. = ..()
	update_icon()

/obj/item/solar_assembly/New()
	. = ..()
	ADD_SAVED_VAR(tracker)
	ADD_SAVED_VAR(glass_type)
	ADD_SKIP_EMPTY(glass_type)

/obj/machinery/power/solar_control/New()
	..()
	ADD_SAVED_VAR(targetdir)
	ADD_SAVED_VAR(track)
	ADD_SAVED_VAR(trackrate)
	ADD_SAVED_VAR(nexttime)

/obj/machinery/power/solar_control/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/power/solar_control/LateInitialize()
	..()
	spawn(5)
		connect_to_network()
		if(!connect_to_network())
			return
		search_for_connected()
		if(connected_tracker && track == 2)
			connected_tracker.set_angle(GLOB.sun.angle)
		src.set_panels(cdir)

/obj/machinery/power/solar_control/after_load()
	..()
	src.search_for_connected()
	if(connected_tracker && track == 2)
		connected_tracker.set_angle(GLOB.sun.angle)
	src.set_panels(cdir)

/obj/machinery/power/solar_control/proc/connect_panel(var/obj/machinery/power/solar/S)
	if(!S.control) //i.e unconnected
		S.set_control(src)
		connected_panels |= S

/obj/machinery/power/solar_control/search_for_connected()
	if(!powernet)
		return
	for(var/obj/machinery/power/M in powernet.nodes)
		if(istype(M, /obj/machinery/power/solar))
			connect_panel(M)
		else if(istype(M, /obj/machinery/power/tracker))
			if(!connected_tracker) //if there's already a tracker connected to the computer don't add another
				var/obj/machinery/power/tracker/T = M
				if(!T.control) //i.e unconnected
					connected_tracker = T
					T.set_control(src)

/obj/machinery/power/solar_control/Initialize()
	. = ..()
	if(!connect_to_network()) return
	set_panels(cdir)

/obj/machinery/power/solar_control/Topic(href, href_list)
	if(href_list["disconnect"])
		for(var/obj/machinery/power/solar/M in connected_panels)
			M.unset_control()
		if(connected_tracker)
			connected_tracker.unset_control()
		return
	return ..()