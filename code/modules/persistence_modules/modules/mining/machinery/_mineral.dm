/obj/machinery/mineral/Destroy()
	input_turf = null
	output_turf = null
	if(console && !ispath(console))
		console.disconnect_machine(src)
		console = null
	. = ..()

/obj/machinery/mineral/after_load()
	..()
	set_input(input_turf)
	set_output(output_turf)

/obj/machinery/mineral/attackby(var/obj/item/O, var/mob/user)
	if(isMultitool(O))
		var/obj/item/device/multitool/mt = O
		var/obj/machinery/mach = mt.get_buffer(/obj/machinery)
		if(mach)
			mt.set_buffer(null)
			if(connect_machine(mach))
				to_chat(user, "<span class='notice'>You connect \the [src] to \the [console]!</span>")
			else
				to_chat(user, "<span class='warning'>Nothing happens..</span>")
		else
			mt.set_buffer(src)
			to_chat(user, "<span class='notice'>You set \the [mt]'s buffer to \the [src]!</span>")
		return
	. = ..()

/obj/machinery/mineral/proc/connect_machine(var/obj/machinery/mach)
	if(mach == src)
		return FALSE

	if(istype(mach, /obj/machinery/computer/mining))
		console = mach
		console.connect_machine(src)
		return TRUE

	return FALSE

