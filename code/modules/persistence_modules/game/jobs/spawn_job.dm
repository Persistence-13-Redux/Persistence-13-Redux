
// /datum/spawnpoint/faction/beacon/New(var/faction_uid)
// 	. = ..()
// 	src.assigned_faction_uid = faction_uid
// 	var/datum/world_faction/F = FindFaction(faction_uid)
// 	if(!F)
// 		assigned_faction_uid = null
// 		return //Skip adding to list if the faction doesn't exist
// 	if(!GLOB.faction_spawnpoints_beacons)
// 		GLOB.faction_spawnpoints_beacons = list()
// 	GLOB.faction_spawnpoints_beacons[assigned_faction_uid] = src
// 	update_spawn_turfs()

// /datum/spawnpoint/faction/beacon/Destroy()
// 	if(GLOB.faction_spawnpoints_beacons)
// 		GLOB.faction_spawnpoints_beacons[assigned_faction_uid] = null
// 	return ..()

// /datum/spawnpoint/faction/beacon/proc/update_spawn_turfs()
// 	if(!assigned_faction_uid)
// 		return
// 	turfs.Cut()
// 	for(var/obj/machinery/frontier_beacon/B in GLOB.frontierbeacons)
// 		if(B && B.loc && B.faction_uid == assigned_faction_uid)
// 			turfs += B

GLOBAL_VAR(faction_spawn_types)
/proc/get_faction_spawn_types()
	if(!GLOB.faction_spawn_types)
		GLOB.faction_spawn_types = list()
		for(var/types in typesof(/datum/spawnpoint/faction)-/datum/spawnpoint/faction)
			var/datum/spawnpoint/faction/S = types
			var/display_name = initial(S.display_name)
			if((display_name in GLOB.using_map.allowed_spawns) || initial(S.always_visible))
				GLOB.faction_spawn_types[display_name] = new S
	return GLOB.faction_spawn_types

/*
	Definition for a job meant to identify a spawn context for new characters.
	After Spawn the job is cleared.
*/
/datum/job/spawnonly
	title = "Civilian"
	latejoin_at_spawnpoints = FALSE //We always latejoin in persistence mode
	create_record = TRUE

//This returns a spawnpoint datum containing all the possible turfs that can be spawned on
/datum/job/spawnonly/get_spawnpoint(var/client/C)
	if(!C)
		CRASH("Null client passed to get_spawnpoint_for() proc!")

	var/mob/H = C.mob
	var/faction_uid = C.prefs.starting_faction_uid
	var/datum/spawnpoint/faction/spawnpos = ..()

	//A little hack here to override the default behavior of spawnpoints
	//Since bay always assume they're setup once, ever. But we need to re-evaluate on each spawn
	if(istype(spawnpos, /datum/spawnpoint/faction))
		. = spawnpos.get_spawnpoint_with_turfs(H, faction_uid)

//We need to check if we can spawn as a job according to the starting faction
/datum/job/spawnonly/is_available(var/client/caller)
	. = ..()
	if(!. || !caller.prefs)
		return .
	var/datum/world_faction/F = FindFaction(caller.prefs.starting_faction_uid)
	if(!F)
		return FALSE
	var/list/beacons = GetFactionFrontierBeacons(F.uid)
	if(!F.isNewPlayerSpawningAllowed() || !beacons || !LAZYLEN(beacons))
		return FALSE

/datum/job/spawnonly/get_unavailable_reasons(var/client/caller)
	var/list/reasons = ..()
	var/datum/world_faction/F = FindFaction(caller.prefs.starting_faction_uid)
	var/list/beacons = GetFactionFrontierBeacons(F.uid)
	if(!F)
		reasons["No valid starting faction selected!"] = TRUE
	if(!F.isNewPlayerSpawningAllowed())
		reasons["The selected faction has disallowed new player spawning!"] = TRUE
	if(!beacons || !LAZYLEN(beacons))
		reasons["The selected faction has all its arrival teleporters deactivated!"] = TRUE
	if(LAZYLEN(reasons))
		. = reasons

/datum/job/spawnonly/setup_account(var/mob/living/carbon/human/H)
	. = ..()

//
// SUBMAP SPAWNING
//
/datum/job/spawnonly/submap
	title = "Survivor"
	supervisors = "your conscience"
	account_allowed = TRUE
	latejoin_at_spawnpoints = TRUE
	announced = FALSE
	create_record = TRUE
	total_positions = -1
	outfit_type = /decl/hierarchy/outfit/job/assistant
	hud_icon = "hudblank"
	available_by_default = TRUE
	allowed_ranks = null
	allowed_branches = null
	skill_points = 25
	give_psionic_implant_on_join = FALSE
	max_skill = list(   SKILL_BUREAUCRACY = SKILL_MAX,
	                    SKILL_FINANCE = SKILL_MAX,
	                    SKILL_EVA = SKILL_MAX,
	                    SKILL_MECH = SKILL_MAX,
	                    SKILL_PILOT = SKILL_MAX,
	                    SKILL_HAULING = SKILL_MAX,
	                    SKILL_COMPUTER = SKILL_MAX,
	                    SKILL_BOTANY = SKILL_MAX,
	                    SKILL_COOKING = SKILL_MAX,
	                    SKILL_COMBAT = SKILL_MAX,
	                    SKILL_WEAPONS = SKILL_MAX,
	                    SKILL_FORENSICS = SKILL_MAX,
	                    SKILL_CONSTRUCTION = SKILL_MAX,
	                    SKILL_ELECTRICAL = SKILL_MAX,
	                    SKILL_ATMOS = SKILL_MAX,
	                    SKILL_ENGINES = SKILL_MAX,
	                    SKILL_DEVICES = SKILL_MAX,
	                    SKILL_SCIENCE = SKILL_MAX,
	                    SKILL_MEDICAL = SKILL_MAX,
	                    SKILL_ANATOMY = SKILL_MAX,
	                    SKILL_CHEMISTRY = SKILL_MAX)

	var/info = "You have survived a terrible disaster. Make the best of things that you can."
	var/rank
	var/branch
	var/list/spawnpoints
	var/datum/submap/owner
	var/list/blacklisted_species = RESTRICTED_SPECIES
	var/list/whitelisted_species = UNRESTRICTED_SPECIES

/datum/job/submap/New(var/datum/submap/_owner, var/abstract_job = FALSE)
	if(!abstract_job)
		spawnpoints = list()
		owner = _owner
		..()

/datum/job/submap/is_species_allowed(var/datum/species/S)
	if(LAZYLEN(whitelisted_species) && !(S.name in whitelisted_species))
		return FALSE
	if(S.name in blacklisted_species)
		return FALSE
	if(owner && owner.archetype)
		if(LAZYLEN(owner.archetype.whitelisted_species) && !(S.name in owner.archetype.whitelisted_species))
			return FALSE
		if(S.name in owner.archetype.blacklisted_species)
			return FALSE
	return TRUE

/datum/job/submap/is_restricted(var/datum/preferences/prefs, var/feedback)
	var/datum/species/S = all_species[prefs.species]
	if(LAZYACCESS(minimum_character_age, S.get_bodytype()) && (prefs.age < minimum_character_age[S.get_bodytype()]))
		to_chat(feedback, "<span class='boldannounce'>Not old enough. Minimum character age is [minimum_character_age[S.get_bodytype()]].</span>")
		return TRUE
	if(LAZYLEN(whitelisted_species) && !(prefs.species in whitelisted_species))
		to_chat(feedback, "<span class='boldannounce'>Your current species, [prefs.species], is not permitted as [title] on \a [owner.archetype.descriptor].</span>")
		return TRUE
	if(prefs.species in blacklisted_species)
		to_chat(feedback, "<span class='boldannounce'>Your current species, [prefs.species], is not permitted as [title] on \a [owner.archetype.descriptor].</span>")
		return TRUE
	if(owner && owner.archetype)
		if(LAZYLEN(owner.archetype.whitelisted_species) && !(prefs.species in owner.archetype.whitelisted_species))
			to_chat(feedback, "<span class='boldannounce'>Your current species, [prefs.species], is not permitted on \a [owner.archetype.descriptor].</span>")
			return TRUE
		if(prefs.species in owner.archetype.blacklisted_species)
			to_chat(feedback, "<span class='boldannounce'>Your current species, [prefs.species], is not permitted on \a [owner.archetype.descriptor].</span>")
			return TRUE
	return FALSE