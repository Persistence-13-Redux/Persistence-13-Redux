/obj/machinery/atmospherics/omni/filter/Initialize()
	. = ..()
	do_init()

/obj/machinery/atmospherics/omni/filter/New()
	..()
	ADD_SAVED_VAR(gas_filters)
	ADD_SAVED_VAR(input)
	ADD_SAVED_VAR(output)
	ADD_SAVED_VAR(set_flow_rate)
	ADD_SAVED_VAR(filtering_outputs)

/obj/machinery/atmospherics/omni/filter/after_load()
	rebuild_filtering_list()
	for(var/datum/omni_port/P in ports)
		handle_port_change(P)
	..()

/obj/machinery/atmospherics/omni/filter/proc/do_init()
	rebuild_filtering_list()
	for(var/datum/omni_port/P in ports)
		P.air.volume = ATMOS_DEFAULT_VOLUME_FILTER

//Override to handle reagents
/obj/machinery/atmospherics/omni/filter/sort_ports()
	for(var/datum/omni_port/P in ports)
		if(P.update)
			if(output == P)
				output = null
			if(input == P)
				input = null
			if(P in gas_filters)
				gas_filters -= P

			P.air.volume = ATMOS_DEFAULT_VOLUME_FILTER
			switch(P.mode)
				if(ATM_INPUT)
					input = P
				if(ATM_OUTPUT)
					output = P
				if(ATM_O2 to ATM_RG)
					gas_filters += P

//Override to handle reagents
/obj/machinery/atmospherics/omni/filter/mode_send_switch(var/mode = ATM_NONE)
	if(mode == ATM_RG)
		return "Reagents"
	return ..()

//Override to handle reagents
/obj/machinery/atmospherics/omni/filter/Topic(href, href_list)
	//only allows config changes when in configuring mode ~otherwise you'll get weird pressure stuff going on
	if(configuring && !use_power)
		if(href_list["command"] == "switch_filter")
			var/new_filter = input(usr,"Select filter mode:","Change filter",href_list["mode"]) in list("None", "Oxygen", "Nitrogen", "Carbon Dioxide", "Phoron", "Nitrous Oxide", "Hydrogen", "Reagents")
			switch_filter(dir_flag(href_list["dir"]), mode_return_switch(new_filter))

	if(..()) return 1

	update_icon()
	SSnano.update_uis(src)
	return

//Override to handle reagents
/obj/machinery/atmospherics/omni/filter/mode_return_switch(var/mode)
	if(mode == "Reagents")
		return ATM_RG
	return ..()

//Override to handle reagents
/obj/machinery/atmospherics/omni/filter/rebuild_filtering_list()
	filtering_outputs.Cut()
	for(var/datum/omni_port/P in ports)
		var/list/gasids = mode_to_gasid(P.mode)
		if(gasids)
			for(var/gid in gasids)
				filtering_outputs[gid] = P.air
