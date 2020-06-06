/obj/machinery/portable_atmospherics/hydroponics/New()
	. = ..()
	ADD_SAVED_VAR(waterlevel)
	ADD_SAVED_VAR(nutrilevel)
	ADD_SAVED_VAR(pestlevel)
	ADD_SAVED_VAR(weedlevel)
	ADD_SAVED_VAR(dead)
	ADD_SAVED_VAR(harvest)
	ADD_SAVED_VAR(age)
	ADD_SAVED_VAR(sampled)
	ADD_SAVED_VAR(yield_mod)
	ADD_SAVED_VAR(mutation_mod)
	ADD_SAVED_VAR(toxins)
	ADD_SAVED_VAR(mutation_level)
	ADD_SAVED_VAR(tray_light)
	ADD_SAVED_VAR(plant_health)
	ADD_SAVED_VAR(closed_system)
	ADD_SAVED_VAR(temp_chem_holder)
	ADD_SAVED_VAR(labelled)
	ADD_SAVED_VAR(seed)

//Force base class to keep our loaded saved variables
/obj/machinery/portable_atmospherics/hydroponics/Initialize()
	var/old_temp_chem_holder
	var/old_reagents
	if(map_storage_loaded)
		old_reagents = reagents
		old_temp_chem_holder = temp_chem_holder
	. = ..()
	if(map_storage_loaded)
		reagents = old_reagents
		temp_chem_holder = old_temp_chem_holder
	
/obj/machinery/portable_atmospherics/hydroponics/SetupReagents()
	. = ..()
	if(!temp_chem_holder)
		temp_chem_holder = new()
		temp_chem_holder.create_reagents(100)
		temp_chem_holder.atom_flags |= ATOM_FLAG_OPEN_CONTAINER
	if (!reagents) create_reagents(200)
