/obj/machinery/power/port_gen/pacman/New()
	..()
	ADD_SAVED_VAR(sheets)
	ADD_SAVED_VAR(sheet_left)
	ADD_SAVED_VAR(operating_temperature)

/obj/machinery/power/port_gen/pacman/super/New()
	. = ..()
	ADD_SAVED_VAR(rad_power)
