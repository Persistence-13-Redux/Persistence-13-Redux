/obj/machinery/atmospherics/unary/vent_scrubber
	use_power = POWER_USE_IDLE
	var/area_uid
	var/radio_filter_out = RADIO_TO_AIRALARM
	var/radio_filter_in = RADIO_TO_AIRALARM

/obj/machinery/atmospherics/unary/vent_scrubber/New()
	..()
	ADD_SAVED_VAR(welded)
	ADD_SAVED_VAR(scrubbing)
	ADD_SAVED_VAR(scrubbing_gas)
	ADD_SAVED_VAR(panic)

/obj/machinery/atmospherics/unary/vent_scrubber/after_load()
	. = ..()
	//Check if we've got non-existent gases, or new ones
	var/list/toremove = list()
	for(var/g in scrubbing_gas)
		if(!(g in gas_data.gases))
			toremove += g
	scrubbing_gas -= toremove

/obj/machinery/atmospherics/unary/vent_scrubber/Destroy()
	// if(initial_loc)
	// 	initial_loc.air_scrub_names -= id_tag
	return ..()

/obj/machinery/atmospherics/unary/vent_scrubber/Initialize()
	// if(loc)
	// 	initial_loc = get_area(loc)
	// 	area_uid = initial_loc.uid
	var/had_id = !id_tag
	.=..()
	if(had_id)
		id_tag = make_loc_string_id("ASV") //Make a default id
	if(!scrubbing_gas)
		scrubbing_gas = list()
		for(var/g in gas_data.gases)
			if(g != GAS_OXYGEN && g != GAS_NITROGEN)
				scrubbing_gas += g
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/atmospherics/unary/vent_scrubber/Process()
	if(isnull(loc))
		return
	return ..()

// Handles toggling gases to scrub
/obj/machinery/atmospherics/unary/vent_scrubber/proc/handle_gas_toggling(var/list/sigdata)
