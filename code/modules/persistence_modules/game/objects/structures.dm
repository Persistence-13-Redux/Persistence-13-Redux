/obj/structure/Destroy()
	material = null
	return ..()

/obj/structure/Initialize(mapload)
	. = ..()
	if(!mapload)
		update_connections(TRUE)
	else
		update_connections(FALSE) //Don't propagate during init!!!

