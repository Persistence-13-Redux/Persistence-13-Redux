/obj/machinery/ai_status_display/Initialize(mapload, d)
	. = ..()
	queue_icon_update()

/obj/machinery/ai_status_display/on_update_icon()
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = -30
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = 30
		if(EAST)
			src.pixel_x = -30
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = 30
			src.pixel_y = 0
	if(inoperable())
		overlays.Cut()
		return

