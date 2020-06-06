/obj/machinery/cell_charger/New()
	..()
	ADD_SAVED_VAR(charging)
	ADD_SAVED_VAR(chargelevel)

/obj/machinery/cell_charger/Destroy()
	if(charging)
		charging.forceMove(get_turf(src))
	charging = null
	return ..()
