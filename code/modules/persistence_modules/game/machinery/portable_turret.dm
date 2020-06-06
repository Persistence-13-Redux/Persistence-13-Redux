#define TURRET_PRIORITY_TARGET 2
#define TURRET_SECONDARY_TARGET 1
#define TURRET_NOT_TARGET 0

/obj/machinery/porta_turret
	var/detect_range = 7	//engagement range of the turret, forming a square from the tile of the turret(Default 2*7+1=15)
	var/check_faction = 0	//should the turret shoot if the target isn't of the parent faction
	var/ui_mode = 0
	req_access = list(access_security, access_bridge)
	var/list/selected_access = list() //{name = selection type}

//Reimplement the ui completely
/obj/machinery/porta_turret/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data[0]
	data["access"] = !isLocked(user)
	data["locked"] = locked
	data["enabled"] = enabled
	data["is_lethal"] = TRUE
	data["lethal"] = lethal

	if(data["access"])
		var/settings[0]
		settings[++settings.len] = list("category" = "Neutralize All Non-Synthetics", "setting" = "check_synth", "value" = check_synth)
		settings[++settings.len] = list("category" = "Check Weapon Authorization", "setting" = "check_weapons", "value" = check_weapons)
		settings[++settings.len] = list("category" = "Check Security Records", "setting" = "check_records", "value" = check_records)
		settings[++settings.len] = list("category" = "Check Arrest Status", "setting" = "check_arrest", "value" = check_arrest)
		settings[++settings.len] = list("category" = "Check Faction Authorization", "setting" = "check_faction", "value" = check_faction)
		settings[++settings.len] = list("category" = "Check Access Authorization", "setting" = "check_access", "value" = check_access)
		settings[++settings.len] = list("category" = "Check misc. Lifeforms", "setting" = "check_anomalies", "value" = check_anomalies)
		data["settings"] = settings

	data["range"] = detect_range
	data["minrange"] = 1
	data["maxrange"] = 7
	data["connected_faction"] = faction
	data["ui_mode"] = ui_mode

	if(!locked && data["allowed"] > 1 && ui_mode)	//Save performance by making sure we only do this if they can access it
		var/list/access_list = list()
		for(var/datum/access/A in faction.get_all_accesses()) // code/modules/factions/faction.dm
			var/list/button_data = list()
			button_data["name"] = A.desc // Use the associated list to get the name
			button_data["id"] = A.id
			button_data["selected"] = selected_access[A.id]
			access_list[++access_list.len] = button_data
		data["access"] = access_list

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "turret_control.tmpl", "Turret Controls", 500, 300)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/porta_turret/OnTopic(mob/user, href_list, datum/topic_state/state)
	if(href_list["command"] && href_list["value"])
		var/value = text2num(href_list["value"])
		if(href_list["command"] == "check_faction")
			check_faction = value
		else if(href_list["command"] == "ui_mode")
			ui_mode = value
		else if(href_list["command"] == "range")
			detect_range += value
		else if(href_list["command"] == "access")
			selected_access[value] = value
			apply_selected_access()
		return TOPIC_REFRESH
	return ..()

/obj/machinery/porta_turret/attackby(obj/item/I, mob/user)
	if(!faction_uid && istype(I, /obj/item/weapon/card/id) || I.GetIdCard())
		var/obj/item/weapon/card/id/theid = I.GetIdCard()
		if(!src.get_faction() && theid.get_faction())
			connect_faction(theid.get_faction(), user)
			for(var/access in user.GetAccess(faction_uid))
				selected_access["[access]"] = 3
			to_chat(user, "<span class='notice'>\The [src] has been synced to your faction</span>")
			return
	. = ..()

/obj/machinery/porta_turret/die()	//called when the turret dies, ie, health <= 0
	. = ..()
	update_icon()

//Reimplement for setting detection range...
/obj/machinery/porta_turret/Process()
	if(stat & (NOPOWER|BROKEN))
		//if the turret has no power or is broken, make the turret pop down if it hasn't already
		popDown()
		return

	if(!enabled)
		//if the turret is off, make it pop down
		popDown()
		return

	var/list/targets = list()			//list of primary targets
	var/list/secondarytargets = list()	//targets that are least important

	for(var/mob/M in mobs_in_view(detect_range, src))
		assess_and_assign(M, targets, secondarytargets)

	if(!tryToShootAt(targets))
		if(!tryToShootAt(secondarytargets)) // if no valid targets, go for secondary targets
			popDown() // no valid targets, close the cover

	if(auto_repair && (health < maxhealth))
		use_power_oneoff(20000)
		health = min(health+1, maxhealth) // 1HP for 20kJ

/obj/machinery/porta_turret/assess_living(var/mob/living/L)
	if(!L)
		return TURRET_NOT_TARGET
	if(!istype(L))
		return TURRET_NOT_TARGET
	if(L.invisibility >= INVISIBILITY_LEVEL_ONE) // Cannot see him. see_invisible is a mob-var
		return TURRET_NOT_TARGET

	if(istype(L, /mob/living/simple_animal/hostile))// Spiders are very dangerous
		return TURRET_PRIORITY_TARGET
	if(issilicon(L)) // if the target is a silicon, analyze threat level
		if(assess_borgo(L) < 4)
			return TURRET_NOT_TARGET	//if threat level < 4, keep going
	if(issilicon(L)) // if the target is a silicon, analyze threat level
		if(assess_borgo(L) < 4)
			return TURRET_NOT_TARGET	//if threat level < 4, keep going
	if(istype(L, /mob/living/bot)) //if the target is a bot, decide if it is ours
	//	if(assess_bot(L))
		return TURRET_NOT_TARGET
	. = ..()

//Re-implemented
/obj/machinery/porta_turret/assess_perp(var/mob/living/carbon/human/H)
	if(!H || !istype(H))
		return 0

	if(emagged)
		return 10

	if(!get_faction()) //safety check
		check_faction = 0
		check_access = 0

	if(faction && H.get_faction() != faction_uid)
		return 10

	if(check_access)
		for(var/access in H.GetAccess(faction_uid))
			if(req_access["[access]"] > 0)
				return H.assess_perp(src, 0, 0, 1, 1, faction)
		return 10 //if they don't have any of the required access

	return H.assess_perp(src, 0, 0, 1, 1, faction) //if we're not checking faction or access, we're solely looking at wanted status, Arrest = pew pew

/obj/machinery/porta_turret/proc/assess_borgo(var/mob/living/silicon/robot/R)
	if(!R || !istype(R))
		return 0
	if(emagged)
		return 10
	if(!src.get_faction()) //safety check
		check_faction = 0
		check_access = 0
	if(faction && R.get_faction() != faction_uid)
		return 10
	if(check_access)
		for(var/access in R.GetAccess(faction_uid))
			if(req_access["[access]"] > 0)
				// Robots can call assess_perp too since they are mob/livings
				return R.assess_perp(src, 0, 0, 1, 1, faction)
		return 10 //if they don't have any of the required access

	return R.assess_perp(src, 0, 0, 1, 1, faction) //if we're not checking faction or access, we're solely looking at wanted status, Arrest = pew pew

/obj/machinery/porta_turret/proc/assess_bot(var/mob/living/bot/B)
	if(!B || !istype(B))
		return 1
	if(emagged)
		return 0
	if(!istype(B, /mob/living/bot/secbot)) //Enemy cleanbots are not a threat to our existence
		return 1
	return B.connected_faction_uid == req_access_faction

/obj/machinery/porta_turret/proc/apply_selected_access()
	req_access.Cut()
	for(var/key in selected_access)
		if(selected_access[key])
			req_access += key

#undef TURRET_PRIORITY_TARGET
#undef TURRET_SECONDARY_TARGET
#undef TURRET_NOT_TARGET