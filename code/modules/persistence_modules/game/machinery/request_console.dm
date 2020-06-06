/obj/machinery/requests_console
	frame_type = /obj/item/frame/request_console

/obj/machinery/requests_console/on_update_icon()
	. = ..()
	pixel_x = 0
	pixel_y = 0
	switch(dir)
		if(NORTH)
			pixel_y = -32
		if(SOUTH)
			pixel_y = 32
		if(WEST)
			pixel_x = 34
		if(EAST)
			pixel_x = -34
