/obj/machinery/smartfridge/New()
	..()
	ADD_SAVED_VAR(item_records)
	ADD_SAVED_VAR(locked)
	ADD_SAVED_VAR(is_secure)
	ADD_SAVED_VAR(scan_id)

/obj/machinery/smartfridge/Initialize(mapload)
	. = ..()
	if(mapload)
		queue_icon_update()
	else
		update_icon()

/obj/machinery/smartfridge/proc/DumpInstances()
	for(var/datum/stored_items/S in item_records)
		for(var/obj/item/I in S.instances)
			I.dropInto(loc)
			S.instances -= I

/obj/machinery/smartfridge/dismantle()
	DumpInstances()
	return ..()

/obj/machinery/smartfridge/Destroy()
	DumpInstances()
	return ..()