/obj/machinery/power/breakerbox/New()
	..()
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(RCon_tag)

/obj/machinery/power/breakerbox/activated/Initialize()
	var/old_state = on
	. = ..()
	if(map_storage_loaded)
		set_state(old_state)