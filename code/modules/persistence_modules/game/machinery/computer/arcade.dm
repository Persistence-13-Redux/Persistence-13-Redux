/obj/machinery/computer/arcade/Initialize()
	if(map_storage_loaded)
		random = FALSE //Make sure the base arcade doesn't try to randomize the machine on save load
	. = ..()
