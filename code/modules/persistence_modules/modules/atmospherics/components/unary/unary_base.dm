/obj/machinery/atmospherics/unary/New()
	..()
	ADD_SAVED_VAR(air_contents)

//Keep base code from overwriting saved values
/obj/machinery/atmospherics/unary/Initialize()
	var/old_air_content = air_contents
	. = ..()
	if(map_storage_loaded)
		air_contents = old_air_content

/obj/machinery/atmospherics/unary/disconnect(obj/machinery/atmospherics/reference)
	if(reference == node)
		QDEL_NULL(network) //Be sure to null out the old network or bad shit will happen..
	return ..()

