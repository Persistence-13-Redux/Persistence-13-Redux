/obj/machinery/portable_atmospherics/powered/scrubber
	desc = "Portable air contaminant scrubber. Works on rechargeable power cells."

/obj/machinery/portable_atmospherics/powered/scrubber/New()
	. = ..()
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(volume_rate)
	ADD_SAVED_VAR(scrubbing_gas)

/obj/machinery/portable_atmospherics/powered/scrubber/Process()
	//No point in running in nullspace!
	if(isnull(loc) || QDELETED(src))
		return PROCESS_KILL
	. = ..()

/obj/machinery/portable_atmospherics/powered/scrubber/huge
	desc = "A larger variant of the smaller portable scrubber. Work on APC power, controlled via Area Air Control Console."
