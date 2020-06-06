/obj/structure/anomaly_container
	matter = list(MATERIAL_PLASTEEL = 10 SHEETS)

/obj/structure/anomaly_container/attackby(obj/item/O, mob/user)
	if(default_deconstruction_wrench(O, user, 10 SECONDS))
		dismantle()
		return 1
	else
		return ..()

/obj/structure/anomaly_container/New()
	. = ..()
	ADD_SAVED_VAR(contained)

/obj/structure/anomaly_container/Destroy()
	contained = null
	. = ..()

/obj/structure/anomaly_container/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/anomaly_container/LateInitialize()
	. = ..()
	if(!map_storage_loaded)
		var/obj/machinery/artifact/A = locate() in loc
		if(A)
			contain(A)