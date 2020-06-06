//# TODO : Refactor faction radio

/obj/item/device/radio
	var/faction_uid = ""
	var/public_mode = 1 // if this is on, the radio will send and recieve signals with no faction association

/obj/item/device/radio/New()
	. = ..()
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(frequency)
	ADD_SAVED_VAR(traitor_frequency)
	ADD_SAVED_VAR(canhear_range)
	ADD_SAVED_VAR(b_stat)
	ADD_SAVED_VAR(broadcasting)
	ADD_SAVED_VAR(listening)
	ADD_SAVED_VAR(channels)
	ADD_SAVED_VAR(custom_channels)
	ADD_SAVED_VAR(subspace_transmission)
	ADD_SAVED_VAR(syndie)
	ADD_SAVED_VAR(intercept)
	ADD_SAVED_VAR(faction_uid)
	ADD_SAVED_VAR(public_mode)
	ADD_SAVED_VAR(cell)

/obj/item/device/radio/proc/getfaction(var/mob/user)
	faction_uid = user.get_faction()
	message_admins("faction_uid:[faction_uid]")

obj/item/device/radio/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data[0]

	data["mic_status"] = broadcasting
	data["speaker"] = listening
	data["freq"] = format_frequency(frequency)
	data["rawfreq"] = num2text(frequency)
	var/obj/item/weapon/cell/has_cell = get_cell()
	if(has_cell)
		var/charge = round(has_cell.percent())
		data["charge"] = charge ? "[charge]%" : "NONE"
	data["mic_cut"] = (wires.IsIndexCut(WIRE_TRANSMIT) || wires.IsIndexCut(WIRE_SIGNAL))
	data["spk_cut"] = (wires.IsIndexCut(WIRE_RECEIVE) || wires.IsIndexCut(WIRE_SIGNAL))
	var/datum/world_faction/connected_faction
	if(faction_uid && faction_uid != "")
		connected_faction = FindFaction(faction_uid)
	if(!connected_faction)
		faction_uid = ""
		public_mode = 1
	data["connected_faction"] = connected_faction ? connected_faction.name : "Not connected."
	data["public_mode"] = public_mode ? "On" : "Off"
	var/list/chanlist = list_channels(user)
	if(islist(chanlist) && chanlist.len)
		data["chan_list"] = chanlist
		data["chan_list_len"] = chanlist.len

	if(syndie)
		data["useSyndMode"] = 1

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "radio_basic.tmpl", "[name]", 400, 430)
		ui.set_initial_data(data)
		ui.open()

/obj/item/device/radio/Topic(href, href_list)
	if(href_list["connect_to_faction"])
		getfaction(usr)
		. = 1
	if(href_list["toggle_public_mode"])
		public_mode = !public_mode
		. = 1
	if(.)
		SSnano.update_uis(src)
	. = ..()

/obj/item/device/radio/borg/after_load()
	..()
	if(!myborg && istype(loc, /mob/living))
		myborg = loc
