/obj/machinery/recharge_station/after_load()
	for(var/mob/M in contents)
		M.loc = get_turf(src)

/obj/machinery/recharge_station/New()
	..()
	ADD_SAVED_VAR(occupant)
