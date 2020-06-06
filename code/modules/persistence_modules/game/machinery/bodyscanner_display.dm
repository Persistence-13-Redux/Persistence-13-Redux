/obj/machinery/body_scan_display/New()
	. = ..()
	ADD_SAVED_VAR(bodyscans)
	ADD_SAVED_VAR(selected)


/obj/machinery/body_scan_display/on_update_icon()
	..()
	if(!ispowered())
		icon_state = icon_state_unpowered
	else
		icon_state = initial(icon_state)

	src.pixel_x = 0
	src.pixel_y = 0
	switch(dir)
		if(NORTH)
			src.pixel_y = -24
		if(SOUTH)
			src.pixel_y = 24
		if(EAST)
			src.pixel_x = -30
		if(WEST)
			src.pixel_x = 30