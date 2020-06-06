
//Make sure this doesn't create new parts on load
/obj/machinery/populate_parts(var/full_populate)
	if(map_storage_loaded)
		return
	. = ..()