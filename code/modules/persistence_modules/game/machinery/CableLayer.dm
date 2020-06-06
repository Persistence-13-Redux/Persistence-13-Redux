/obj/machinery/cablelayer
	max_cable = 500

/obj/machinery/cablelayer/New()
	..()
	ADD_SAVED_VAR(cable)
	ADD_SAVED_VAR(on)