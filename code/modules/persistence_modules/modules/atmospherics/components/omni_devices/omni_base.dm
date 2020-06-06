/obj/machinery/atmospherics/omni/New()
	..()
	ADD_SAVED_VAR(ports)

/obj/machinery/atmospherics/omni/after_load()
	update_ports()
	..()
