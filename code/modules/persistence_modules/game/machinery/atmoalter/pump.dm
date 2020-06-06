/obj/machinery/portable_atmospherics/powered/pump
	desc = "Portable air pump. Works on power cells."

/obj/machinery/portable_atmospherics/powered/pump/New()
	. = ..()
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(direction_out)
	ADD_SAVED_VAR(target_pressure)

/obj/machinery/portable_atmospherics/powered/pump/init_air_content()
	..()
	var/list/air_mix = StandardAirMix()
	src.air_contents.adjust_multi(GAS_OXYGEN, air_mix[GAS_OXYGEN], GAS_NITROGEN, air_mix[GAS_NITROGEN])


