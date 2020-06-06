/obj/machinery/light_switch
	name 				= "light switch"
	desc 				= "It turns lights on and off. What are you, simple?"
//	icon 				= 'icons/obj/machines/buttons.dmi'
//	icon_state 			= "light0"
	density 			= FALSE
	idle_power_usage 	= 5
	active_power_usage 	= 20
	frame_type 			= /obj/item/frame/light_switch

/obj/machinery/light_switch/New(loc, dir, atom/frame)
	..(loc)
	if(dir)
		src.set_dir(dir)
	if(istype(frame))
		on = FALSE
		frame.transfer_fingerprints_to(src)
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(other_area)

/obj/machinery/light_switch/before_save()
	. = ..()
	var/area/curarea = get_area(src)
	if(connected_area && connected_area.name != curarea?.name && !other_area)
		other_area = connected_area.name

/obj/machinery/light_switch/Initialize()
	if(!get_area(src))
		return INITIALIZE_HINT_LATELOAD
	. = ..()
	if(. != INITIALIZE_HINT_QDEL)
		return INITIALIZE_HINT_LATELOAD

/obj/machinery/light_switch/LateInitialize()
	. = ..()
	if(other_area)
		connected_area = locate(other_area)
		other_area = null
	else
		connected_area = get_area(src)

	if(name == initial(name))
		SetName("light switch ([connected_area.name])")

	if(!isnull(connected_area))
		connected_area.set_lightswitch(on)
	sync_state()
	queue_icon_update()

/obj/machinery/light_switch/on_update_icon()
	pixel_x = 0
	pixel_y = 0
	switch(dir)
		if(NORTH)
			pixel_y = -22
		if(SOUTH)
			pixel_y = 22
		if(EAST)
			pixel_x = 22
		if(WEST)
			pixel_x = -22
	. = ..()

