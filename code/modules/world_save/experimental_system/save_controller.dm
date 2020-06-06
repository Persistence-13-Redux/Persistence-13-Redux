var/global/datum/controller/save_controller/SaveController = new()

/*
	Handles saving and loading the game
*/
/datum/controller/save_controller
	var/const/DEFAULT_MAP_SAVE_DIRECTORY = "map_save/"

/*
	By default the game doesn't load a map, and just pieces a map together at runtime
*/
/datum/controller/save_controller/proc/InitWorld()
	if(ShouldLoadMapFile())
		//load the initial map template file
		GLOB.using_map.load_base_map()
	else
		//load the save instead
		SaveController.LoadWorld()

// /datum/map_template/load(no_changeturf = TRUE)
// /datum/map_template/proc/load(turf/T, centered=FALSE)
// 	if(centered)
// 		T = locate(T.x - round(width/2) , T.y - round(height/2) , T.z)
// 	if(!T)
// 		return
// 	if(T.x+width > world.maxx)
// 		return
// 	if(T.y+height > world.maxy)
// 		return

// 	var/list/atoms_to_initialise = list()
// 	var/shuttle_state = pre_init_shuttles()

// 	var/initialized_areas_by_type = list()
// 	for (var/mappath in mappaths)
// 		var/datum/map_load_metadata/M = maploader.load_map(file(mappath), T.x, T.y, T.z, cropMap=TRUE, clear_contents=(template_flags & TEMPLATE_FLAG_CLEAR_CONTENTS), initialized_areas_by_type = initialized_areas_by_type)
// 		if (M)
// 			atoms_to_initialise += M.atoms_to_initialise
// 		else
// 			return FALSE

// 	//initialize things that are normally initialized after map load
// 	init_atoms(atoms_to_initialise)
// 	init_shuttles(shuttle_state)
// 	after_load(T.z)
// 	SSlighting.InitializeTurfs(atoms_to_initialise)	// Hopefully no turfs get placed on new coords by SSatoms.
// 	log_game("[name] loaded at at [T.x],[T.y],[T.z]")
// 	loaded++

// 	return TRUE
/datum/map
	var/list/initial_map_files = list() //file paths for all the initial z-levels of the map in order

/datum/map/proc/load_base_map()
	for(var/map_template_name in (SSmapping.map_templates))
		var/datum/map_template/base_map/map_template = SSmapping.map_templates[map_template_name]
	var/datum/map_template/base_map = new(initial_map_files, "base")



/datum/controller/save_controller/proc/ShouldLoadMapFile()
	//Check if we got something saved

	//If not, load the default
	return TRUE

/datum/controller/save_controller/proc/SaveWorld()
/datum/controller/save_controller/proc/LoadWorld()