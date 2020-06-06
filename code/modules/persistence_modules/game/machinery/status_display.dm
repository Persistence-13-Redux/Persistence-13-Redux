/obj/machinery/status_display
	mode = STATUS_DISPLAY_BLANK	// 0 = Blank
									// 1 = Shuttle timer
									// 2 = Arbitrary message(s)
									// 3 = alert picture
									// 4 = Supply shuttle timer
	frame_type 			= /obj/item/frame/status_display

/obj/machinery/status_display/Initialize()
	. = ..()
	update_icon()

/obj/machinery/status_display/update_icon()
	..()
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = -24
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = 28
		if(EAST)
			src.pixel_x = -30
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = 30
			src.pixel_y = 0

/obj/machinery/status_display/update()
	switch(mode)
		if(STATUS_DISPLAY_TRANSFER_SHUTTLE_TIME)
			if(!evacuation_controller) //We don't have evac
				return FALSE
	. = ..()


