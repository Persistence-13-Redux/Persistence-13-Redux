/datum/spawnpoint/faction

//Basically return a new copy of itself with properly filled faction related spawn turfs
/datum/spawnpoint/faction/proc/get_spawnpoint_with_turfs(var/mob/victim, var/faction_uid)
	return new src.type()

//======================================
//	Faction beacon spawnpoint
//======================================
/datum/spawnpoint/faction/beacon
	msg = ""
	display_name = "Arrival Teleporter"
	always_visible = TRUE	// Whether this spawn point is always visible in selection, ignoring map-specific settings.

/datum/spawnpoint/faction/beacon/after_join(mob/victim)
	. = ..()

//Little hack to get the the proper spawnpoint for each factions
/datum/spawnpoint/faction/beacon/get_spawnpoint_with_turfs(var/mob/victim, var/faction_uid)
	var/datum/spawnpoint/faction/SP = ..()
	var/list/obj/machinery/frontier_beacon/LB = GetFactionFrontierBeacons(faction_uid)
	var/datum/world_faction/F = FindFaction(faction_uid)
	if(!LB || !length(LB) || !F.isNewPlayerSpawningAllowed())
		return null
	LAZYINITLIST(SP.turfs)
	for(var/obj/machinery/frontier_beacon/B in LB)
		if(B.can_accept_spawn())
			SP.turfs += get_turf(B)
	return SP

//======================================
//	Cryonet Spawn
//======================================
/datum/spawnpoint/faction/cryonet
	msg = ""
	display_name = "Last Cryonet"

/datum/spawnpoint/faction/cryonet/after_join(mob/victim)
	. = ..()

//Fill the possible spawn turfs for cryonets with the appropriate turfs
/datum/spawnpoint/faction/cryonet/get_spawnpoint_with_turfs(var/mob/victim)
	var/datum/spawnpoint/faction/SP = ..()
	var/datum/character_records/CR = GetCharacterRecord(victim.real_name)
	if(!CR)
		log_error("Tried to get spawnpoint for [victim], ckey: [victim.ckey], but couldn't find a character record for [victim.real_name]..")
		return SP //No records??
	if(!victim.saved_cryonet)
		log_error("No saved cryonet data for [victim], ckey: [victim.ckey]. Spawn type was set to [victim.spawn_type].")
		return SP
	switch(victim.spawn_type)
		if(CHARACTER_SPAWN_TYPE_CRYONET)
			for(var/obj/machinery/cryopod/C in GLOB.cryopods)
				if(C.faction_uid == victim.saved_cryonet?.cryonet_faction_uid && C.network == victim.saved_cryonet?.cryonet_name)
					SP.turfs += get_turf(C)
		if(CHARACTER_SPAWN_TYPE_PERSONAL)
			for(var/obj/machinery/cryopod/personal/C in GLOB.cryopods)
				if(C.network == victim.saved_cryonet?.cryonet_name)
					SP.turfs += get_turf(C)
	return SP

//======================================
//	Storage Spawn
//======================================
/datum/spawnpoint/faction/storage
	msg = ""
	display_name = "Last Long Term Storage"

/datum/spawnpoint/faction/storage/after_join(mob/victim)
	. = ..()