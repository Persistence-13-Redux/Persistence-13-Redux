/obj/machinery/pager
	frame_type = /obj/item/frame/pager

/obj/machinery/pager/Initialize()
	if(QDELETED(src) || !loc)
		return INITIALIZE_HINT_QDEL //If there's no area its in nullspace
	. = ..()
	queue_icon_update()

/obj/machinery/pager/update_icon()
	..()
	var/turf/T = get_step(get_turf(src), GLOB.reverse_dir[dir])
	if(istype(T) && T.density)
		switch(dir)
			if(NORTH)
				src.pixel_x = 0
				src.pixel_y = -26
			if(SOUTH)
				src.pixel_x = 0
				src.pixel_y = 26
			if(EAST)
				src.pixel_x = -22
				src.pixel_y = 0
			if(WEST)
				src.pixel_x = 22
				src.pixel_y = 0
	else
		//Since we can be placed on the floor, or tables or whatever
		src.pixel_x = 0
		src.pixel_y = 0