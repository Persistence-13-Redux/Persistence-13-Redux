/obj/machinery/atmospherics/unary/freezer/New()
	..()
	ADD_SAVED_VAR(power_setting)
	ADD_SAVED_VAR(set_temperature)

/obj/machinery/atmospherics/unary/freezer/Initialize(mapload, d)
	. = ..()
	if(!map_storage_loaded)
		initialize_directions = dir
