GLOBAL_LIST_EMPTY(all_factionalized_relays)

// Relays don't handle any actual communication. Global NTNet datum does that, relays only tell the datum if it should or shouldn't work.
/obj/machinery/ntnet_relay/factionalized
	name = "Net Quantum Relay"
	desc = "Handles running factionalized networks functions for the owners. Looks very fragile."
	construct_state = /decl/machine_construction/default/panel_closed
	uncreated_component_parts = null
	stat_immune = 0

/obj/machinery/ntnet_relay/factionalized/register_relay()
	if(NTNet)
		NTNet.relays |= src
		NTNet.add_log("New quantum relay activated. Current amount of linked relays: [NTNet.relays.len]")
	GLOB.all_factionalized_relays |= src

/obj/machinery/ntnet_relay/factionalized/unregister_relay()
	if(GLOB.all_factionalized_relays)
		GLOB.all_factionalized_relays -= src
	if(NTNet)
		NTNet.relays -= src
		NTNet.add_log("Quantum relay connection severed. Current amount of linked relays: [NTNet.relays.len]")

/obj/machinery/ntnet_relay/factionalized/connect_faction(datum/world_faction/F, mob/user)
	. = ..()
	if(faction)
		NTNet = faction.network

/obj/machinery/ntnet_relay/factionalized/disconnect_faction(mob/user)
	. = ..()
	if(.)
		NTNet = null

/obj/machinery/ntnet_relay/factionalized/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = GLOB.default_state)
	var/list/data = list()
	var/datum/ntnet/faction/NF = NTNet
	data["enabled"] = enabled
	data["dos_capacity"] = dos_capacity
	data["dos_overload"] = dos_overload
	data["dos_crashed"] = dos_failure
	data["portable_drive"] = !!get_component_of_type(/obj/item/weapon/stock_parts/computer/hard_drive/portable)
	data["faction_name"] = faction? faction.name : "null"
	data["network_uid"] = NF? NF.uid : "null"
	data["has_valid_network"] = NF? 1 : 0

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "ntnet_relay_faction.tmpl", "Net Quantum Relay", 500, 300, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/ntnet_relay/factionalized/OnTopic(mob/user, href_list, datum/topic_state/state)
	if(href_list["restart"])
		dos_overload = 0
		dos_failure = 0
		update_icon()
		if(NTNet)
			NTNet.add_log("Quantum relay manually restarted from overload recovery mode to normal operation mode.")
		return TOPIC_REFRESH
	else if(href_list["toggle"])
		enabled = !enabled
		if(NTNet)
			NTNet.add_log("Quantum relay manually [enabled ? "enabled" : "disabled"].")
		update_icon()
		return TOPIC_REFRESH
	else if(href_list["purge"])
		if(NTNet)
			NTNet.banned_nids.Cut()
			NTNet.add_log("Manual override: Network blacklist cleared.")
		return TOPIC_REFRESH
	else if(href_list["eject_drive"] && uninstall_component(/obj/item/weapon/stock_parts/computer/hard_drive/portable))
		visible_message("\icon[src] [src] beeps and ejects its portable disk.")
		return TOPIC_REFRESH
	else if(href_list["refresh_network"])
		if(NTNet)
			connect_faction(faction.uid, user)
			register_relay()
		return TOPIC_REFRESH
	else if(href_list["set_faction"])
		var/obj/item/weapon/card/id/I = usr.GetIdCard()
		if(I && I.get_faction_uid())
			connect_faction(I.get_faction_uid(), usr)
			if(NTNet)
				visible_message("\icon[src] [src]'s lights starts flickering. Connection successful!")
				register_relay()
			else
				visible_message("\icon[src] [src]'s flickering lights shutoff. Connection failed..")
		return TOPIC_REFRESH
