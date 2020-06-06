#define AALARM_SCREEN_ADV_FILTER 6	//Screen for adding specific gases to specific scrubbers

/decl/environment_data
	filter_gasses = list(
		GAS_OXYGEN =         list("command" = "o2_scrub",  "value" = "filter_o2"),
		GAS_NITROGEN =       list("command" = "n2_scrub",  "value" = "filter_n2"),
		GAS_CO2 =            list("command" = "co2_scrub", "value" = "filter_co2"),
		GAS_N2O =            list("command" = "n2o_scrub", "value" = "filter_n2o"),
		GAS_PHORON =         list("command" = "tox_scrub", "value" = "filter_phoron")
	)

/obj/machinery/alarm
	id_tag = null
	frequency			= AIRALARM_FREQ
	var/radio_filter_in		= RADIO_TO_AIRALARM
	var/radio_filter_out	= RADIO_FROM_AIRALARM
	var/co_dangerlevel = 0 
	var/filter_tweak_scrubber = null //The selected scrubber for editing advanced filter settings

/obj/machinery/alarm/New(var/loc, var/dir, atom/frame)
	. = ..()
	ADD_SAVED_VAR(remote_control)
	ADD_SAVED_VAR(rcon_setting)
	ADD_SAVED_VAR(shorted)
	ADD_SAVED_VAR(wiresexposed)
	ADD_SAVED_VAR(aidisabled)
	ADD_SAVED_VAR(locked)
	ADD_SAVED_VAR(mode)
	ADD_SAVED_VAR(buildstage)
	ADD_SAVED_VAR(target_temperature)
	ADD_SAVED_VAR(TLV)
	ADD_SAVED_VAR(report_danger_level)
	ADD_SAVED_VAR(breach_detection)

/obj/machinery/alarm/Initialize()
	alarm_area = get_area(src)
	if(!alarm_area)
		log_debug(" /obj/machinery/alarm/Initialize() : Alarm is in null area on initialize!!")
		return
	
	//Next make sure the default code doesn't replace our loaded value
	var/list/OldTLV = TLV.Copy()
	. = ..()
	if(OldTLV && length(OldTLV))
		TLV = OldTLV

/obj/machinery/alarm/Destroy()
	filter_tweak_scrubber = null
	alarm_area = null
	return ..()

/obj/machinery/alarm/after_load()
	. = ..()
	alarm_area = get_area(src)
	if(!alarm_area)
		log_debug(" /obj/machinery/alarm/after_load() : [src]\ref[src]'s area is null area after load!!")
		return
	area_uid = alarm_area.uid
	if(!TLV)
		log_warning(" obj/machinery/alarm/after_load(): TLV for [src]\ref[src] after loading was null!!")
		TLV = list()

/obj/machinery/alarm/Process()
	if(loc == null || isinspace())
		return PROCESS_KILL
	. = ..()

/obj/machinery/alarm/overall_danger_level(var/datum/gas_mixture/environment)
	var/partial_pressure = R_IDEAL_GAS_EQUATION*environment.temperature/environment.volume
	co_dangerlevel = get_danger_level(environment.gas[GAS_CO]*partial_pressure, TLV[GAS_CO])
	. = ..()
	. = max(., co_dangerlevel)

/obj/machinery/alarm/on_update_icon()
	if(!alarm_area)
		return
	. = ..()

/obj/machinery/alarm/receive_signal(datum/signal/signal)
	if(!alarm_area)
		log_warning("\"[src]\"(\ref[src]) ([x], [y], [z]): has invalid alarm area \"[alarm_area]\", and receiving a signal..")
		return 
	. = ..()
	if (signal.data["sigtype"] != "status")
		return

/obj/machinery/alarm/proc/refresh_all()
	for(var/id_tag in alarm_area.air_vent_names)
		var/list/I = alarm_area.air_vent_info[id_tag]
		if (I && I["timestamp"]+AALARM_REPORT_TIMEOUT/2 > world.time)
			continue
		send_signal(id_tag, list("status") )
	for(var/id_tag in alarm_area.air_scrub_names)
		var/list/I = alarm_area.air_scrub_info[id_tag]
		if (I && I["timestamp"]+AALARM_REPORT_TIMEOUT/2 > world.time)
			continue
		send_signal(id_tag, list("status") )

//Replace the proc completely since we're passing some extra stuff to machines
/obj/machinery/alarm/apply_mode()
	//propagate mode to other air alarms in the area
	//TODO: make it so that players can choose between applying the new mode to the room they are in (related area) vs the entire alarm area
	for (var/obj/machinery/alarm/AA in alarm_area)
		AA.mode = mode

	switch(mode)
		if(AALARM_MODE_SCRUBBING)
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 1, "gas_scrub" = GAS_CO2, "gas_scrub_state"= 1, "set_scrubbing"= SCRUBBER_SCRUB, "panic_siphon"= 0) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("set_power"= 1, "set_checks"= "default", "set_external_pressure"= "default") )

		// if(AALARM_MODE_EXCHANGE)
		// 	for(var/device_id in alarm_area.air_scrub_names)
		// 		send_signal(device_id, list("power"= 1, "gas_scrub" = GAS_CO2, "gas_scrub_state"= 1, "set_scrubbing"= SCRUBBER_EXCHANGE, "panic_siphon"= 0) )
		// 	for(var/device_id in alarm_area.air_vent_names)
		// 		send_signal(device_id, list("power"= 1, "checks"= "default", "set_external_pressure"= "default") )

		if(AALARM_MODE_PANIC, AALARM_MODE_CYCLE)
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 1, "panic_siphon"= 1) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("set_power"= 0) )

		if(AALARM_MODE_REPLACEMENT)
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 1, "panic_siphon"= 1) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("set_power"= 1, "set_checks"= "default", "set_external_pressure"= "default") )

		if(AALARM_MODE_FILL)
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("power"= 0) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("set_power"= 1, "set_checks"= "default", "set_external_pressure"= "default") )

		if(AALARM_MODE_OFF)
			for(var/device_id in alarm_area.air_scrub_names)
				send_signal(device_id, list("set_power"= 0) )
			for(var/device_id in alarm_area.air_vent_names)
				send_signal(device_id, list("set_power"= 0) )


/obj/machinery/alarm/populate_controls(var/list/data)
	switch(screen)
		if(AALARM_SCREEN_MAIN)
			data["mode"] = mode
		if(AALARM_SCREEN_VENT)
			var/vents[0]
			for(var/id_tag in alarm_area.air_vent_names)
				var/long_name = alarm_area.air_vent_names[id_tag]
				var/list/info = alarm_area.air_vent_info[id_tag]
				if(!info)
					continue
				vents[++vents.len] = list(
						"id_tag"	= id_tag,
						"long_name" = sanitize(long_name),
						"power"		= info["power"],
						"checks"	= info["checks"],
						"direction"	= info["direction"],
						"external"	= info["external"],
						"internal"  = info["internal"]
					)
			data["vents"] = vents
		if(AALARM_SCREEN_SCRUB)
			var/scrubbers[0]
			for(var/id_tag in alarm_area.air_scrub_names)
				var/long_name = alarm_area.air_scrub_names[id_tag]
				var/list/info = alarm_area.air_scrub_info[id_tag]
				if(!info)
					continue
				scrubbers[++scrubbers.len] = list(
						"id_tag"	= id_tag,
						"long_name" = sanitize(long_name),
						"power"		= info["power"],
						"scrubbing"	= info["scrubbing"],
						"panic"		= info["panic"],
						"filters"	= list()
					)
				var/decl/environment_data/env_info = decls_repository.get_decl(environment_type)
				for(var/gas_id in env_info.filter_gasses)
					var/list/filter_data = env_info.filter_gasses[gas_id]
					scrubbers[scrubbers.len]["filters"] += list(
						list(
							"name" =    gas_data.name[gas_id],
							"command" = filter_data["command"],
							"val" =     info[filter_data["value"]]
						)
					)

			data["scrubbers"] = scrubbers
		if(AALARM_SCREEN_MODE)
			var/modes[0]
			modes[++modes.len] = list("name" = "Filtering - Scrubs out contaminants", 			"mode" = AALARM_MODE_SCRUBBING,		"selected" = mode == AALARM_MODE_SCRUBBING, 	"danger" = 0)
			modes[++modes.len] = list("name" = "Replace Air - Siphons out air while replacing", "mode" = AALARM_MODE_REPLACEMENT,	"selected" = mode == AALARM_MODE_REPLACEMENT,	"danger" = 0)
			modes[++modes.len] = list("name" = "Panic - Siphons air out of the room", 			"mode" = AALARM_MODE_PANIC,			"selected" = mode == AALARM_MODE_PANIC, 		"danger" = 1)
			modes[++modes.len] = list("name" = "Cycle - Siphons air before replacing", 			"mode" = AALARM_MODE_CYCLE,			"selected" = mode == AALARM_MODE_CYCLE, 		"danger" = 1)
			modes[++modes.len] = list("name" = "Fill - Shuts off scrubbers and opens vents", 	"mode" = AALARM_MODE_FILL,			"selected" = mode == AALARM_MODE_FILL, 			"danger" = 0)
			modes[++modes.len] = list("name" = "Off - Shuts off vents and scrubbers", 			"mode" = AALARM_MODE_OFF,			"selected" = mode == AALARM_MODE_OFF, 			"danger" = 0)
			data["modes"] = modes
			data["mode"] = mode
		if(AALARM_SCREEN_SENSORS)
			var/list/selected
			var/thresholds[0]

			var/list/gas_names = list(
				GAS_OXYGEN		= "O<sub>2</sub>",
				GAS_CO2			= "CO<sub>2</sub>",
				GAS_CO			= "CO",
				GAS_PHORON		= "Toxin",
				"other"			= "Other")
			for (var/g in gas_names)
				thresholds[++thresholds.len] = list("name" = gas_names[g], "settings" = list())
				selected = TLV[g]
				for(var/i = 1, i <= 4, i++)
					thresholds[thresholds.len]["settings"] += list(list("env" = g, "val" = i, "selected" = selected[i]))

			selected = TLV["pressure"]
			thresholds[++thresholds.len] = list("name" = "Pressure", "settings" = list())
			for(var/i = 1, i <= 4, i++)
				thresholds[thresholds.len]["settings"] += list(list("env" = "pressure", "val" = i, "selected" = selected[i]))

			selected = TLV["temperature"]
			thresholds[++thresholds.len] = list("name" = "Temperature", "settings" = list())
			for(var/i = 1, i <= 4, i++)
				thresholds[thresholds.len]["settings"] += list(list("env" = "temperature", "val" = i, "selected" = selected[i]))

			data["thresholds"] 			= thresholds
			data["report_danger_level"] = report_danger_level
			data["breach_detection"] 	= breach_detection

		if(AALARM_SCREEN_ADV_FILTER)
			data["scrubber_name"] = alarm_area.air_scrub_names[filter_tweak_scrubber]
			data["scrubber_id_tag"] = filter_tweak_scrubber
			var/list/handled_gases[0]
			for(var/g in gas_data.gases)
				handled_gases[++handled_gases.len] = list("gas_id" = g, "name" = gas_data.name[g], "state" = (g in alarm_area.air_scrub_info[filter_tweak_scrubber]["filtered"]))
			data["gases_entries"] = handled_gases

/obj/machinery/alarm/OnTopic(user, href_list, var/datum/topic_state/state)

	// hrefs that need the AA unlocked -walter0o
	var/extra_href = state.href_list(user)
	if(!(locked && !extra_href["remote_connection"]) || extra_href["remote_access"] || issilicon(user))
		if(href_list["command"])
			var/device_id = href_list["id_tag"]
			switch(href_list["command"])
				if("set_internal_pressure")
					var/input_pressure = input(user, "What pressure you like the system to mantain?", "Pressure Controls") as num|null
					if(isnum(input_pressure) && CanUseTopic(user, state))
						send_signal(device_id, list(href_list["command"] = input_pressure))
					return TOPIC_HANDLED

				if("reset_internal_pressure")
					send_signal(device_id, list(href_list["command"] = 0))
					return TOPIC_HANDLED

				if( "power",
					"direction",
					"adjust_external_pressure",
					"checks",
					"o2_scrub",
					"n2_scrub",
					"co2_scrub",
					"tox_scrub",
					"n2o_scrub",
					"panic_siphon")

					send_signal(device_id, list(href_list["command"] = text2num(href_list["val"]) ) )
					return TOPIC_REFRESH
				
				if("gas_scrub")
					send_signal(device_id, list(href_list["command"] = href_list["val"], "gas_scrub_state" = href_list["gas_scrub_state"] ))
					return TOPIC_REFRESH
				
				if("adv_filtering")
					filter_tweak_scrubber = href_list["id_tag"]
					screen = AALARM_SCREEN_ADV_FILTER
					return TOPIC_REFRESH

				if("scrubbing")
					send_signal(device_id, list(href_list["command"] = href_list["scrub_mode"]) )
					return TOPIC_REFRESH

		if(href_list["toggle_breach_detection"])
			breach_detection = !breach_detection
			return TOPIC_HANDLED

		if(href_list["toggle_report_danger_level"])
			report_danger_level = !report_danger_level
			return TOPIC_HANDLED


#undef AALARM_SCREEN_ADV_FILTER

// Request updates for air vents and scrubbers which appear to have been added.
/obj/machinery/alarm/power_change()
	. = ..()
	if(. && !(stat & NOPOWER) && alarm_area)
		for(var/id_tag in alarm_area.air_vent_names)
			if(!alarm_area.air_vent_info[id_tag])
				send_signal(id_tag, list("status" = TRUE))
		for(var/id_tag in alarm_area.air_scrub_names)
			if(!alarm_area.air_scrub_info[id_tag])
				send_signal(id_tag, list("status" = TRUE))

/obj/machinery/alarm/receive_signal(datum/signal/signal)
	if(stat & (NOPOWER|BROKEN))
		return
	return ..()


