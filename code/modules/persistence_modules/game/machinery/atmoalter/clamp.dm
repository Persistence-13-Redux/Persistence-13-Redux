/obj/item/clamp
	matter = list(MATERIAL_STEEL = 300, MATERIAL_GLASS = 500)

/obj/machinery/clamp/New(loc, var/obj/machinery/atmospherics/pipe/simple/to_attach = null)
	. = ..()
	ADD_SAVED_VAR(open)

/obj/machinery/clamp/LateInitialize()
	. = ..()
	if(open)
		open()
	else
		close()
