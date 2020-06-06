/obj/structure/extinguisher_cabinet/empty/New()
	..()
	has_extinguisher = null

/obj/structure/extinguisher_cabinet/New()
	. = ..()
	ADD_SAVED_VAR(opened)
	ADD_SAVED_VAR(has_extinguisher)

/obj/structure/extinguisher_cabinet/on_update_icon()
	. = ..()
	pixel_x = 0
	pixel_y = 0
	switch(dir)
		if(NORTH)
			pixel_y = 24
		if(SOUTH)
			pixel_y = -24
		if(EAST)
			pixel_x = 24
		if(WEST)
			pixel_x = -24
