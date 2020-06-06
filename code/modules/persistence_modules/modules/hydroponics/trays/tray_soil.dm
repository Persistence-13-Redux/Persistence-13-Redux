/obj/machinery/portable_atmospherics/hydroponics/soil/attackby(var/obj/item/O as obj, var/mob/user as mob)
	if(isShovel(O))
		dismantle()
		return 1
	return ..()

/obj/machinery/portable_atmospherics/hydroponics/soil/invisible/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/portable_atmospherics/hydroponics/soil/invisible/LateInitialize()
	. = ..()
	if(seed)
		plant_health = seed.get_trait(TRAIT_ENDURANCE)
	else
		log_warning("[src]\ref[src]'s seed was null on init!'")
		plant_health = 1
	check_health()

/obj/machinery/portable_atmospherics/hydroponics/soil/invisible/after_load()
	. = ..()
	if(seed)
		name = seed.display_name