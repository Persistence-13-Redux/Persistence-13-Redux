/obj/effect/submap_landmark/joinable_submap/buffalo
	name = BUFFALO_SHIP_NAME
	archetype = /decl/submap_archetype/derelict/buffalo

/decl/submap_archetype/derelict/buffalo
	descriptor = "light freighter"
	map = BUFFALO_SHIP_NAME
	crew_jobs = list(
		/datum/job/submap/buffalo_captain,
		/datum/job/submap/buffalo_crewman
	)

/datum/map_template/ruin/away_site/buffalo
	name = BUFFALO_SHIP_NAME
	id = BUFFALO_AWAY_SITE_ID
	description = "A civilian light freighter."
	suffixes = list("buffalo/buffalo-1.dmm", "buffalo/buffalo-2.dmm")
	cost = 1
	//shuttles_to_initialise = list(/datum/shuttle/autodock/ferry/lift)
	area_usage_test_exempted_root_areas = list(/area/ship)
	// apc_test_exempt_areas = list(
	// 	/area/ship/scrap/maintenance/engine/port = NO_SCRUBBER|NO_VENT,
	// 	/area/ship/scrap/maintenance/engine/starboard = NO_SCRUBBER|NO_VENT,
	// 	/area/ship/scrap/crew/hallway/port= NO_SCRUBBER|NO_VENT,
	// 	/area/ship/scrap/crew/hallway/starboard= NO_SCRUBBER|NO_VENT,
	// 	/area/ship/scrap/maintenance/hallway = NO_SCRUBBER|NO_VENT,
	// 	/area/ship/scrap/maintenance/lower = NO_SCRUBBER|NO_VENT,
	// 	/area/ship/scrap/maintenance/atmos = NO_SCRUBBER,
	// 	/area/ship/scrap/escape_port = NO_SCRUBBER|NO_VENT,
	// 	/area/ship/scrap/escape_star = NO_SCRUBBER|NO_VENT,
	// 	/area/ship/scrap/shuttle/lift = NO_SCRUBBER|NO_VENT|NO_APC,
	// 	/area/ship/scrap/command/hallway = NO_SCRUBBER|NO_VENT
	// )