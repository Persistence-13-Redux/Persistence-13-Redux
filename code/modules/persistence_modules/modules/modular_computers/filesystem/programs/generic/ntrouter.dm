/datum/computer_file/program/ntnetrouter
	filename = "ntrouter"
	filedesc = "Network Selection"
	program_icon_state = "comm_monitor"
	program_menu_icon = "wrench"
	extended_desc = "This program allows switching between bluespace networks."
	size = 1
	requires_ntnet = FALSE
	available_on_ntnet = FALSE
	usage_flags = PROGRAM_ALL
	nanomodule_path = /datum/nano_module/program/computer_ntrouter/

/datum/nano_module/program/computer_ntrouter
	name = "Network Selection"
	available_to_ai = TRUE
	var/password = ""

/datum/nano_module/program/computer_ntrouter/proc/format_networks(var/mob/user)
	var/list/datum/ntnet/faction/found_networks = list()
	var/obj/item/weapon/card/id/id = user.GetIdCard()
	for(var/datum/world_faction/fact in GLOB.all_world_factions)
		if(fact.network)
			if(!fact.network.invisible || (fact.get_stockholder(user.real_name)) || (id && (core_access_network_linking in id.GetAccess(fact.uid))))
				found_networks |= fact.network
	var/list/formatted = list()
	for(var/datum/ntnet/faction/network in found_networks)
		var/connected = FALSE
		var/obj/item/weapon/stock_parts/computer/network_card/NC = program.computer.get_component(PART_NETWORK)
		if(NC && NC.connected_network)
			if(network.get_uid() == NC.network_uid)
				connected = TRUE
		formatted.Add(list(list(
			"display_name" = network.get_name(),
			"net_uid" = network.get_uid(),
			"secured" = network.is_secured(),
			"connected" = connected,
			"ref" = "\ref[network]")))

	return formatted

/datum/nano_module/program/computer_ntrouter/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = host.initial_data()
	var/obj/item/weapon/stock_parts/computer/network_card/NC = program.computer.get_component(PART_NETWORK)
	data["card_installed"] = NC? 1 : 0
	data["connected"] = 0

	if(NC)
		data["has_password"] = NC.network_uid != ""
		data["networks"] = format_networks(user)
		data["connected_to"] = NC.network_uid
		data["display_password"] = length(password)? "****" : ""
		var/datum/ntnet/faction/network = program.get_network()
		if(NC.connected_network)
			data["connected"] = 1
			data["display_name"] = network.get_name()
			data["secured"] = network.is_secured()
		else
			data["attempted"] = NC.network_uid != ""? 1 : 0

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "ntnet_router.tmpl", "Select Network", 575, 700, state = state)
		if(host.update_layout())
			ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/datum/nano_module/program/computer_ntrouter/Topic(href, href_list, state)
	var/obj/item/weapon/stock_parts/computer/network_card/NC = program.computer.get_component(PART_NETWORK)
	if(..())
		return 1
	if(!NC)
		return 1
	if(href_list["disconnect"])
		if(input(usr, "Are you sure you want to disconnect from the network? Network settings wont save.") in list("Confirm", "Cancel") == "Confirm")
			NC.disconnect_from_network()
		return 1
	if(href_list["connect"])
		if(NC.connected_network)
			if(input(usr, "Are you sure you want to connect to a different network? You will be disconnected from your current network and settings wont save.") in list("Confirm", "Cancel") != "Confirm")
				return 1
			NC.disconnect_from_network()
		var/datum/ntnet/faction/network = locate(href_list["connect"])
		if(!network)
			message_admins("ntnet failed to locate")
			return 1
		if(network.secured)
			password = input(usr, "This network requires a password","Enter network password","")
		if(network.check_password(password))
			NC.connect_to_network(network.get_uid())
		return 1
