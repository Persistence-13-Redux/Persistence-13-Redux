GLOBAL_LIST_EMPTY(cargotelepads)

//CARGO TELEPAD//
/obj/machinery/telepad_cargo
	name = "cargo telepad"
	desc = "A telepad used to recieve imports and send exports."
	icon = 'icons/obj/telescience.dmi'
	icon_state = "pad-idle"
	anchored = TRUE
	idle_power_usage = 20
	active_power_usage = 500
	req_access = list(core_access_order_approval)
	matter = list(MATERIAL_STEEL = 2 SHEETS, MATERIAL_GLASS = 2 SHEETS)
	obj_flags = OBJ_FLAG_ANCHORABLE | OBJ_FLAG_ROTATABLE | OBJ_FLAG_CONDUCTIBLE
	construct_state = /decl/machine_construction/default/panel_closed
	
/obj/machinery/telepad_cargo/New()
	..()
	LAZYDISTINCTADD(GLOB.cargotelepads, src)

/obj/machinery/telepad_cargo/Initialize()
	. = ..()

/obj/machinery/telepad_cargo/attack_hand(mob/user)
	// if(!allowed(user))
	// 	to_chat(user, SPAN_WARNING("Access denied!"))
	// 	return TRUE
	return ..()

/obj/machinery/telepad_cargo/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

/obj/machinery/telepad_cargo/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data = list()
	var/datum/world_faction/F = src.get_faction()
	data["connected_faction"] = F ? F.name : "Not connected."
	data["anchored"] = anchored ? "Yes" : "No"
	data["beacon"] = panel_open ? "Unsecured" : "Secured"
	data["label"] = name
	data["connected"] = !isnull(F)
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "cargo_telepad.tmpl", "[name]", 400, 430)
		ui.set_initial_data(data)
		ui.open()

/obj/machinery/telepad_cargo/OnTopic(var/mob/user, href_list, datum/topic_state/state)
	if(href_list["connect_to_faction"])
		if(!allowed(user))
			to_chat(user, SPAN_WARNING("Access denied!"))
			return TOPIC_NOACTION
		var/obj/item/weapon/card/id/idcard = user.GetIdCard()
		if(!idcard?.get_faction())
			to_chat(user, SPAN_WARNING("No faction set!"))
			return TOPIC_NOACTION
		connect_faction(idcard.get_faction(), user)
		return TOPIC_REFRESH_UPDATE_PREVIEW
	else if(href_list["disconnect_from_faction"])
		if(!allowed(user))
			to_chat(user, SPAN_WARNING("Access denied!"))
			return TOPIC_NOACTION
		disconnect_faction(user)
		return TOPIC_REFRESH_UPDATE_PREVIEW
	else if (href_list["change_label"])
		if(allowed(usr))
			var/select_name = sanitizeName(input(usr,"Select new label for the telepad.","Label Change", "") as null|text, MAX_NAME_LEN, 1, 0)
			if(select_name)
				name = select_name
		return TOPIC_REFRESH_UPDATE_PREVIEW
	return ..()