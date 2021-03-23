var/global/datum/world_save/WSAVE = new()
/*
	Save manager for persistence
*/
/datum/world_save
	var/const/single_save_file_name = "world.sav"
	var/tmp/list/debug_data = list()
	var/tmp/previous_allow_enter_state = FALSE //Keep track of the previous state of the server var allowing entering
	var/tmp/last_start_time = -1

	//Current save file
	var/savefile/SF = null

////////////////////////////////////////
// Utility
////////////////////////////////////////

/datum/world_save/proc/PreparePipesForSaving()
	for(var/datum/pipe_network/net in SSmachines.pipenets)
		for(var/datum/pipeline/line in net.line_members)
			line.temporarily_store_air()

/datum/world_save/proc/RotateBackup()
	var/timestamp = time2text(world.realtime, "DD-MM-YYYY_hh-mm")
	var/backup_path = "[config.save_backup_path]/[timestamp]_backup"
	var/save_path = config.save_path
	//#TODO
	PruneBackups()

/datum/world_save/proc/PruneBackups()
	//#TODO: Clear old backups maybe? Or have the server do it?


/datum/world_save/proc/SaveArea(var/area/A, var/savefile/S)
	if(!istype(A) || istype(A, world.area))
		return FALSE
	A.before_save()
	var/old_cd = S.cd
	S.cd = GetAreasPath()
	S.eof = 1 //Move cursor to end of buffer
	to_file(S, A)
	S.cd = old_cd
	S.eof = 1 //Move cursor to end of buffer
	A.after_save()
	return TRUE

/datum/world_save/proc/SaveZone(var/zone/Z, var/savefile/S)
	if(!istype(Z))
		return FALSE
	Z.before_save()
	var/old_cd = S.cd
	S.cd = GetZonesPath()
	S.eof = 1 //Move cursor to end of buffer
	to_file(S, Z)
	S.cd = old_cd
	S.eof = 1 //Move cursor to end of buffer
	Z.after_save()
	return TRUE

//Save dir for areas
/datum/world_save/proc/GetAreasPath()
	return "/AREAS"

//Save dir for air zones
/datum/world_save/proc/GetZonesPath()
	return "/ZONES"

////////////////////////////////////////
// Saving
////////////////////////////////////////
/datum/world_save/proc/SaveWorld()
	_SaveWorldBegin()

	//Prepare things to be saved
	PreparePipesForSaving()
	RotateBackup()

	//Iterate through the world
	// for(var/z in 1 to world.maxz)
	// 	_SaveZLevel(z)
	SF = new("[config.save_path]/[single_save_file_name]")
	SF << world.contents

	//Leave a debug trace if possible
	if(config.save_text_copy && !config.save_per_zlevel)
		var/debug_text = file("logs/save_world.txt")
		fdel(debug_text)
		SF.ExportText("/", debug_text)

	_SaveWorldEnd()
	return TRUE

/datum/world_save/proc/_SaveZLevel(var/z)
	var/savefile/S = _GetLevelSaveFile(z)
	for(var/y in 1 to world.maxy)
		for(var/x in 1 to world.maxx)
			var/turf/T = locate(x,y,z)
			try
				//Save the turf and its content
				T.before_save()
				to_file(S, T)
				T.after_save()
			catch(var/exception/E)
				log_debug("EXCEPTION: ([T.x], [T.y], [T.z]) Saving '[T]' caused an exception : '[E]'")
				continue
	S.Flush()
	//Leave a debug trace if possible
	if(config.save_text_copy && config.save_per_zlevel)
		var/debug_text = file("logs/save_z[z].txt")
		fdel(debug_text)
		S.ExportText("/", debug_text)


//Change this if we want to save everything in the same file, or across several files
/datum/world_save/proc/_GetLevelSaveFile(var/z)
	var/save_path
	if(config.save_per_zlevel)
		save_path = "[config.save_path]/z[z].sav"
		return new/savefile(save_path)
	else
		save_path = "[config.save_path]/[single_save_file_name]"
		if(!SF)
			SF = new(save_path)
		return SF


/datum/world_save/proc/_SaveWorldBegin()
	SF = null
	previous_allow_enter_state = config.enter_allowed
	config.enter_allowed = FALSE
	to_world("<font size=4 color='green'>The world is saving! Characters are frozen and you won't be able to join at this time.</font>")
	sleep(1 SECOND)
	last_start_time = REALTIMEOFDAY

/datum/world_save/proc/_SaveWorldEnd()
	SF = null
	config.enter_allowed = previous_allow_enter_state
	to_world("Saving Completed in [(REALTIMEOFDAY - last_start_time)/10] seconds!")

////////////////////////////////////////
// Loading
////////////////////////////////////////

//Returns whether there is save data to be loaded
/datum/world_save/proc/HasSaveToLoad()
	return fexists("[config.save_path]/[single_save_file_name]") || fexists("[config.save_path]/z1.sav")

/datum/world_save/proc/LoadWorld()
	if(!HasSaveToLoad())
		return FALSE
	_LoadWorldBegin()
	
	//Get rid of any competing areas
	for(var/area/A in world)
		if(istype(A, world.area))
			continue

	SF = new("[config.save_path]/[single_save_file_name]")
	var/list/stuff
	from_file(SF, stuff)

	// var/file_counter = 1
	// SF = _GetLevelSaveFile(file_counter)
	// while(SF)
	// 	//Read the current file completely
	// 	while(!SF.eof)
			
	// 	//Try to get the next file if we're in that mode, otherwise wait for the loop to end
	// 	if(!config.save_per_zlevel)
	// 		break
	// 	file_counter++
	// 	SF = _GetLevelSaveFile(file_counter)

	_LoadWorldEnd()
	return TRUE

/datum/world_save/proc/LoadArea(var/dirname, var/savefile/S)
	//Check if reference or actual instance of object
	var/A 
	from_file(S[dirname], A)
	if(istype(A, /area))
		return A
	else
		return locate(A)



/datum/world_save/proc/LoadZone(var/zone/Z, var/savefile/S)

/datum/world_save/proc/_LoadWorldBegin()
	SF = null
	last_start_time = REALTIMEOFDAY

/datum/world_save/proc/_LoadWorldEnd()
	SF = null
	to_world("Loading Completed in [(REALTIMEOFDAY - last_start_time)/10] seconds!")