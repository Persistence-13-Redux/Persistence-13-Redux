/obj/machinery/computer/guestpass/on_update_icon()
	. = ..()
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = -20
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = 20
		if(EAST)
			src.pixel_x = -20
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = 20
			src.pixel_y = 0
