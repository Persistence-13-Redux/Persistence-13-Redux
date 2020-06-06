/obj/machinery/conveyor/attackby(var/obj/item/I, mob/user)
	if(isMultitool(I))
		var/obj/item/device/multitool/mt = I
		var/obj/machinery/conveyor/M = mt.get_buffer(/obj/machinery/conveyor)
		var/obj/machinery/conveyor_switch/mach = mt.get_buffer(/obj/machinery/conveyor_switch)
		if(mach)
			mt.set_buffer(null)
			src.id = mach.id
			to_chat(user, "<span class='notice'>You connect \the [src] to \the [mach]!</span>")
		else if(M == src)
			mt.set_buffer(null)
			to_chat(user, SPAN_NOTICE("You clear \the [mt]'s buffer."))
		else
			mt.set_buffer(src)
			to_chat(user, "<span class='notice'>You set \the [mt]'s buffer to \the [src]!</span>")
		return
	return ..()


/obj/machinery/conveyor_switch/Initialize()
	. = ..()
	conveyors = list()
	for(var/obj/machinery/conveyor/C in world)
		if(C.id == id)
			conveyors += C

/obj/machinery/conveyor_switch/attackby(obj/item/I, mob/user, params)
	if(isMultitool(I))
		var/obj/item/device/multitool/mt = I
		var/obj/machinery/conveyor_switch/M = mt.get_buffer(/obj/machinery/conveyor_switch)
		var/obj/machinery/conveyor/mach = mt.get_buffer(/obj/machinery/conveyor)
		if(mach)
			mach.id = src.id
			conveyors |= mach
			mt.set_buffer(null)
			to_chat(user, SPAN_NOTICE("You connect \the [src] to \the [mach]!"))
		else if(M == src)
			mt.set_buffer(null)
			to_chat(user, SPAN_NOTICE("You clear \the [mt]'s buffer."))
		else
			mt.set_buffer(src)
			to_chat(user, SPAN_NOTICE("You set \the [mt]'s buffer to \the [src]!"))
		return
	return 	..()