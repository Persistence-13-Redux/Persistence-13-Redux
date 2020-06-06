/obj/machinery/atmospherics/unary/vent_pump
	use_power = POWER_USE_IDLE
	pressure_checks_default = 1 | 2
	var/area/initial_loc
	var/area_uid

/obj/machinery/atmospherics/unary/vent_pump/Initialize()
	if(loc)
		initial_loc = get_area(loc)
		area_uid = initial_loc.uid
	var/had_no_id = !id_tag
	. = ..()
	if (had_no_id)
		id_tag = make_loc_string_id("AVP") //Override the base class bullshit
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/atmospherics/unary/vent_pump/LateInitialize()
	. = ..()
	refresh()
	// if(frequency)
	// 	broadcase_status()

/obj/machinery/atmospherics/unary/vent_pump/New()
	..()
	ADD_SAVED_VAR(pump_direction)
	ADD_SAVED_VAR(welded)
	ADD_SAVED_VAR(external_pressure_bound)
	ADD_SAVED_VAR(internal_pressure_bound)
	ADD_SAVED_VAR(pressure_checks)

/obj/machinery/atmospherics/unary/vent_pump/atmos_init()
	. = ..()
	if(!node)
		update_use_power(POWER_USE_OFF) //Turn off if disconnected

/obj/machinery/atmospherics/unary/vent_pump/Destroy()
	if(initial_loc)
		initial_loc.air_vent_info -= id_tag
		initial_loc.air_vent_names -= id_tag
	. = ..()

/obj/machinery/atmospherics/unary/vent_pump/disconnect(obj/machinery/atmospherics/reference)
	. = ..()
	update_use_power(POWER_USE_OFF)

/obj/machinery/atmospherics/unary/vent_pump/Process()
	if(isnull(loc))
		return
	..()

// /obj/machinery/atmospherics/unary/vent_pump/proc/get_console_data()
// 	. = list()
// 	. += "<table>"
// 	. += "<tr><td><b>Name:</b></td><td>[name]</td>"
// 	. += "<tr><td><b>Pump Status:</b></td><td>[pump_direction?("<font color = 'green'>Releasing</font>"):("<font color = 'red'>Siphoning</font>")]</td><td><a href='?src=\ref[src];switchMode=\ref[src]'>Toggle</a></td></tr>"
// 	. += "<tr><td><b>ID Tag:</b></td><td>[id_tag]</td><td><a href='?src=\ref[src];settag=\ref[id_tag]'>Set ID Tag</a></td></td></tr>"
// 	if(frequency%10)
// 		. += "<tr><td><b>Frequency:</b></td><td>[frequency/10]</td><td><a href='?src=\ref[src];setfreq=\ref[frequency]'>Set Frequency</a></td></td></tr>"
// 	else
// 		. += "<tr><td><b>Frequency:</b></td><td>[frequency/10].0</td><td><a href='?src=\ref[src];setfreq=\ref[frequency]'>Set Frequency</a></td></td></tr>"
// 	.+= "</table>"
// 	. = JOINTEXT(.)
