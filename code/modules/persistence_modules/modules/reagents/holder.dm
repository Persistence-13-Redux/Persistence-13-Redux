
/datum/reagents	//Saving
	var/atom/saved_atom

/datum/reagents/New(var/maximum_volume = 120, var/atom/my_atom)
	//Have to comment this CRASH, because on mapload it breaks everything
	//if(!istype(my_atom))
	//	CRASH("Invalid reagents holder: [log_info_line(my_atom)]")
	..()
	ADD_SAVED_VAR(reagent_list)
	ADD_SAVED_VAR(saved_atom)
	ADD_SAVED_VAR(maximum_volume)
	ADD_SAVED_VAR(total_volume)

/datum/reagents/before_save()
	. = ..()
	saved_atom = my_atom

/datum/reagents/after_load()
	. = ..()
	my_atom = saved_atom
	saved_atom = null // clear it
	
/datum/reagents/Destroy()
	saved_atom = null
	return ..()
