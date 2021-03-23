/datum
	var/tmp/should_save 		= TRUE
	var/tmp/loaded_from_save 	= FALSE //Is true if the entity was loaded from save, otherwise false. Helps with initialization
	var/list/custom_svars 		= null //List of key,value pairs to be saved in addition to everything else. Meant to be used to save extra values without creating useless variables.

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

//Custom saved variables helpers to ensure the custom var table is initialized
/datum/proc/save_custom_value(var/name, var/value)
	if(!custom_svars)
		custom_svars = list()
	custom_svars[name] = value

/datum/proc/load_custom_value(var/name)
	if(!custom_svars)
		return null
	return custom_svars[name]