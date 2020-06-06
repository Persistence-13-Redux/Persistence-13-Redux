/obj/machinery/recharger/New()
	..()
	ADD_SAVED_VAR(charging)
	ADD_SKIP_EMPTY(charging)

/obj/machinery/recharger/Initialize()
	. = ..()
	queue_icon_update()

/obj/machinery/recharger/Destroy()
	if(charging)
		charging.forceMove(get_turf(src))
	charging = null
	return ..()

/obj/machinery/recharger/wallcharger/on_update_icon()
	..()
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = -24
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = 24
		if(EAST)
			src.pixel_x = -24
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = 24
			src.pixel_y = 0

/obj/machinery/recharger/power_change()
	. = ..()
	if(powered())
		update_use_power(POWER_USE_IDLE)
	else
		update_use_power(POWER_USE_OFF)
	queue_icon_update()

/obj/machinery/recharger/set_anchored(new_anchored)
	. = ..()
	if(anchored && operable())
		update_use_power(POWER_USE_IDLE)
	else
		update_use_power(POWER_USE_OFF)

/obj/machinery/recharger/on_update_icon()	//we have an update_icon() in addition to the stuff in process to make it feel a tiny bit snappier.
	if(charging)
		var/obj/item/weapon/cell/C = charging.get_cell()
		if(C && C.fully_charged())
			icon_state = icon_state_charged
		else
			icon_state = icon_state_charging
	else
		icon_state = icon_state_idle