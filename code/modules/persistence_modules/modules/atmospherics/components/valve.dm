/obj/machinery/atmospherics/valve/New()
	. = ..()
	ADD_SAVED_VAR(open)

/obj/machinery/atmospherics/valve/after_load()
	. = ..()
	if(open)
		open()
	else
		close()
