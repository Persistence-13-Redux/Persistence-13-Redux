GLOBAL_LIST_EMPTY(frontierbeacons)

//Returns a list of frontier beacons with the specified owner faction uid
/proc/GetFactionFrontierBeacons(var/faction_uid)
	return GLOB.frontier_beacons_by_faction[faction_uid]

GLOBAL_LIST_EMPTY(frontier_beacons_by_faction) //{faction_uid = list/obj/machinery/frontier_beacon()}

/proc/AddFrontierBeacon(var/obj/machinery/frontier_beacon/B)
	GLOB.frontierbeacons |= B
	if(B.faction_uid)
		if(!GLOB.frontier_beacons_by_faction[B.faction_uid])
			GLOB.frontier_beacons_by_faction[B.faction_uid] = list()
		GLOB.frontier_beacons_by_faction[B.faction_uid] += B

/proc/RemoveFrontierBeacon(var/obj/machinery/frontier_beacon/B)
	GLOB.frontierbeacons -= B
	if(B.faction_uid)
		GLOB.frontier_beacons_by_faction[B.faction_uid] -= B

/proc/UpdateFrontierBeacon(var/obj/machinery/frontier_beacon/B, var/last_faction_uid)
	if(last_faction_uid && GLOB.frontier_beacons_by_faction[last_faction_uid])
		GLOB.frontier_beacons_by_faction[last_faction_uid] -= B
	if(B.faction_uid)
		AddFrontierBeacon(B)

//
//	Frontier_Beacon
//
/obj/machinery/frontier_beacon
	name = "Frontier Beacon"
	desc = "A huge bluespace beacon. The technology is unlike anything you've ever seen, but its apparent that this recieves teleportation signals from the gateway outside the frontier."
	icon = 'code/modules/persistence_modules/icons/obj/frontier_beacon.dmi'
	icon_state = "frontier_beacon"
	anchored = TRUE
	density = FALSE
	use_power = POWER_USE_OFF
	//faction_uid = GLOB.using_map.default_faction_uid

/obj/machinery/frontier_beacon/Initialize()
	AddFrontierBeacon(src)
	return ..()

/obj/machinery/frontier_beacon/Destroy()
	RemoveFrontierBeacon(src)
	return ..()

/obj/machinery/frontier_beacon/connect_faction(datum/world_faction/F, mob/user)
	var/old_faction = faction_uid
	. = ..()
	if(!.)
		return .
	UpdateFrontierBeacon(src, old_faction) //Update the frontier beacon repository

/obj/machinery/frontier_beacon/disconnect_faction(mob/user)
	var/old_faction = faction_uid
	. = ..()
	if(!.)
		return .
	UpdateFrontierBeacon(src, old_faction) //Update the frontier beacon repository

/obj/machinery/frontier_beacon/attackby(obj/item/I, mob/user)
	if(isMultitool(I))
		//Do setup thing
		interface_interact(user)
		return
	return ..()

/obj/machinery/frontier_beacon/interface_interact(mob/user)
	if(!CanPhysicallyInteract(user))
		return FALSE
	if(!allowed(user))
		return FALSE
	ui_interact(user)
	return TRUE

/obj/machinery/frontier_beacon/ui_interact(mob/user, ui_key, datum/nanoui/ui, force_open)
	var/list/data = list()
	data["faction_uid"] = faction_uid
	data["faction_name"] = faction? faction.name : "NONE"
	data["allow_incoming"] = use_power != POWER_USE_OFF
	data["spawn_possible"] = can_accept_spawn()
	
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "frontier_beacon.tmpl", name, 480, 410, state = GLOB.physical_state)
		ui.set_initial_data(data)
		ui.open()

/obj/machinery/frontier_beacon/OnTopic(var/mob/living/user, list/href_list)
	if(href_list["toggle"])
		update_use_power(use_power? POWER_USE_OFF : POWER_USE_IDLE)
		. = TOPIC_REFRESH
	else if(href_list["set_faction_id"])
		var/active_faction_uid = user.get_faction()
		if(active_faction_uid)
			connect_faction(active_faction_uid)
		else
			to_chat(user, SPAN_WARNING("No active faction detected for the current user! Please check your ID card/device for misconfiguration."))
		. = TOPIC_REFRESH
	if(.)
		update_icon()

/obj/machinery/frontier_beacon/proc/can_accept_spawn()
	return use_power && operable() && faction
