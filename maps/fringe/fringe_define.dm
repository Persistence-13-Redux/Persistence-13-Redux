/*
================================================================
Explanation:
================================================================
	The way this map is loaded is a bit special.
	The game will simply load the dummy empty sector map, 
	and later when the time comes to assemble the z-levels it'll
	try to stitch our main station map somewhere. 

	This way, we can check and make sure the games doesn't load
	the map twice when loading saved games.
*/

//-------------------------------
//	Map datum
//-------------------------------
/datum/map/fringe
	name = "Fringe"
	full_name = FRINGE_ORG_NAME_SHORT + FRINGE_STATION_NAME_SHORT
	config_path = "config/fringe_config.txt"
	default_spawn = "Default"
	allowed_jobs = list()

//-------------------------------
//	Away site definition
//-------------------------------
/datum/map_template/ruin/away_site/fringe_waystation
	name = FRINGE_STATION_NAME_SHORT
	id = "awaysite_waystation"
	description = "The gateway to Canis Major."
	prefix = "maps/"
	suffixes = list("fringe/fringe-1.dmm", "fringe/fringe-2.dmm", "fringe/fringe-3.dmm")
	cost = -100 //Don't let the system try to weigth it.. This away site must always be there first

//-------------------------------
//	Submap
//-------------------------------
//Allows us to declare we have jobs to fullfill
/obj/effect/submap_landmark/joinable_submap/fringe_waystation
	name = FRINGE_STATION_NAME_SHORT
	archetype = /decl/submap_archetype/base_map/fringe_waystation

/decl/submap_archetype/base_map/fringe_waystation
	descriptor = FRINGE_STATION_NAME_SHORT
	map = "Fringe"
	crew_jobs = list(
		/datum/job/spawnonly/citizen,
		/datum/job/spawnonly/foreigner,
	)