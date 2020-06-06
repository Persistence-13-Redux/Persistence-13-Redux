/obj/faction_spawner
	name = "Name to start faction with"
	icon = 'code/modules/persistence_modules/icons/misc/map_helpers.dmi'
	icon_state = "faction"
	var/name_short = "Faction Abbreviation"
	var/name_tag = "Faction Tag"
	var/uid = "faction_uid"
	var/password = "starting_password"
	var/network_name = "network name"
	var/network_uid = "network_uid"
	var/network_password
	var/network_invisible = FALSE
	var/decl/hierarchy/outfit/starter_outfit = /decl/hierarchy/outfit/job //Faction's base outfit, is overriden by creation screen

//Psy_commando:
//In order to reliably have the faction spawn and not be deleted, we need to have the faction spawned in LateInitialize().
//Otherwise, when globabl variables are initialized, the all_world_faction list may or may not be overwritten on startup, when not loading a save.
/obj/faction_spawner/Initialize()
	..()
	for(var/datum/world_faction/existing_faction in GLOB.all_world_factions)
		if(existing_faction.uid == uid)
			return INITIALIZE_HINT_QDEL
	var/datum/world_faction/fact = CreateNewFaction(uid, name, name_short, name_tag, desc, network_uid, password)
	fact.network.secured = length(network_password) > 0
	fact.network.invisible = network_invisible
	//fact.starter_outfit = starter_outfit
	LAZYDISTINCTADD(GLOB.all_world_factions, fact)
	return INITIALIZE_HINT_QDEL

/obj/faction_spawner/democratic
	var/purpose = ""

// /obj/faction_spawner/democratic/Initialize()
// 	..()
// 	for(var/datum/world_faction/existing_faction in GLOB.all_world_factions)
// 		if(existing_faction.uid == uid)
// 			return INITIALIZE_HINT_QDEL
// 	var/datum/world_faction/democratic/fact = new()
// 	fact.name = name
// 	fact.abbreviation = name_short
// 	fact.short_tag = name_tag
// 	fact.uid = uid
// 	fact.password = password
// 	fact.network.name = network_name
// 	fact.network.uid = network_uid
// 	fact.desc = src.purpose
// 	if(network_password)
// 		fact.network.secured = 1
// 		fact.network.password = network_password
// 	fact.network.invisible = network_invisible
// 	//fact.starter_outfit = starter_outfit
// 	LAZYDISTINCTADD(GLOB.all_world_factions, fact)
// 	return INITIALIZE_HINT_QDEL