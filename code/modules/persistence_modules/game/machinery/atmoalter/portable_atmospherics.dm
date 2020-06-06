/obj/machinery/portable_atmospherics/New()
	..()
	ADD_SAVED_VAR(holding)
	ADD_SKIP_EMPTY(holding)

/obj/machinery/portable_atmospherics/Initialize()
	. = ..()
	if(!air_contents)
		init_air_content()

// Override this to change the initial air content!
//
/obj/machinery/portable_atmospherics/proc/init_air_content()
	air_contents = new
	air_contents.volume = volume
	air_contents.temperature = T20C
