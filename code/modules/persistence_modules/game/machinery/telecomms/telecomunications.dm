/obj/machinery/telecomms
	var/list/links_coords = list()

/datum/coord_holder
	var/x
	var/y
	var/z
	map_storage_saved_vars = "x;y;z"

/obj/machinery/telecomms/Initialize()
	if(!loc)
		return INITIALIZE_HINT_QDEL
	. = ..()

/obj/machinery/telecomms/before_save()
	links_coords = list()
	for(var/obj/ob in links)
		var/datum/coord_holder/holder = new()
		holder.x = ob.x
		holder.y = ob.y
		holder.z = ob.z
		links_coords += holder

/obj/machinery/telecomms/after_load()
	if(links_coords && links_coords.len)
		for(var/datum/coord_holder/holder in links_coords)
			var/turf/T = locate(holder.x,holder.y,holder.z)
			if(T)
				for(var/obj/machinery/telecomms/tele in T.contents)
					links |= tele

/obj/machinery/telecomms/Process()
	if(!loc)
		return PROCESS_KILL

