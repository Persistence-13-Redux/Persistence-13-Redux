//Base shared variables
/datum
	var/tmp/should_save 			= TRUE
	var/tmp/map_storage_saved_vars	= ""
	var/tmp/skip_empty				= ""
	var/tmp/skip_icon_state 		= 0
	var/tmp/map_storage_loaded 		= 0 // this is special instructions for problematic Initialize()
	var/tmp/list/custom_saved_vars	= null //List of key,value pairs to be saved in addition to everything else. Meant to be used to save extra values without creating useless variables.

//override this changing the value of the parameter to add variables that shouldn't be saved ever
// Make sure to add the return value of the ancestor
/datum/proc/should_never_save(var/list/L = list("parent_type", "vars"))
	return L

/datum/proc/should_save(var/datum/saver)
	return should_save

//Ran before and after loading the datum from a save
/datum/proc/before_load()
	return
/datum/proc/after_load()
	return

//Ran before and after saving the datum to the save file
/datum/proc/before_save()
	return
/datum/proc/after_save() //Sometimes we change the value of some variables for saving purpose only.. and want to change them back after
	return
