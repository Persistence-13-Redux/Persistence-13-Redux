/obj/machinery/atmospherics/pipe/simple/heat_exchanging/atmos_init()
	. = ..()
	if(!node1 && !node2)
		log_debug("Deleted the [src]\ref[src]([x],[y],[z]) on atmos_init() because both nodes were null!")
