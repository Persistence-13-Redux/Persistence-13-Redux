/datum/nano_module/rcon/ui_interact(mob/user, ui_key = "rcon", datum/nanoui/ui=null, force_open=1, var/datum/topic_state/state = GLOB.default_state)
	FindDevices() // Update our devices list
	var/list/data = host.initial_data()

	// SMES DATA (simplified view)
	var/list/smeslist[0]
	for(var/obj/machinery/power/smes/buildable/SMES in known_SMESs)
		smeslist.Add(list(list(
		"charge" = round(SMES.Percentage()),
		"input_set" = SMES.input_attempt,
		"input_val" = round(SMES.input_level/1000, 0.1),
		"input_load" = round(SMES.input_available/1000, 0.1),
		"output_set" = SMES.output_attempt,
		"output_val" = round(SMES.output_level/1000, 0.1),
		"output_load" = round(SMES.output_used/1000, 0.1),
		"RCON_tag" = SMES.RCon_tag
		)))

	data["smes_info"] = sortByKey(smeslist, "RCON_tag")

	// BREAKER DATA (simplified view)
	var/list/breakerlist[0]
	for(var/obj/machinery/power/breakerbox/BR in known_breakers)
		breakerlist.Add(list(list(
		"RCON_tag" = BR.RCon_tag,
		"enabled" = BR.on
		)))
	data["breaker_info"] = breakerlist
	data["hide_smes"] = hide_SMES
	data["hide_smes_details"] = hide_SMES_details
	data["hide_breakers"] = hide_breakers

	var/obj/O = nano_host()
	if(!istype(O, /obj))
		log_warning(" /datum/nano_module/rcon/ui_interact(): No host!")
		return
	data["faction"] = O.req_access_faction

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "rcon.tmpl", "RCON Console", 600, 400, state = state)
		if(host.update_layout()) // This is necessary to ensure the status bar remains updated along with rest of the UI.
			ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/datum/nano_module/rcon/FindDevices()
	var/obj/O = nano_host()
	if(!istype(O, /obj))
		log_warning(" /datum/nano_module/rcon/FindDevices(): No host!")
		return
	var/fac = O.req_access_faction

	known_SMESs = new /list()
	for(var/obj/machinery/power/smes/buildable/SMES in SSmachines.machinery)
		if(AreConnectedZLevels(get_host_z(), get_z(SMES)) && SMES.RCon_tag && (SMES.RCon_tag != "NO_TAG") && SMES.RCon && SMES.req_access_faction == fac)
			known_SMESs.Add(SMES)

	known_breakers = new /list()
	for(var/obj/machinery/power/breakerbox/breaker in SSmachines.machinery)
		if(AreConnectedZLevels(get_host_z(), get_z(breaker)) && breaker.RCon_tag != "NO_TAG" && breaker.req_access_faction == fac)
			known_breakers.Add(breaker)
