/turf/simulated/mineral/before_save()
	. = ..()
	//The turf may have null mineral
	if(istype(mineral))
		custom_saved_vars["mineral"] = mineral.name

/turf/simulated/mineral/after_load()
	. = ..()
	//The turf may have null mineral
	var/_mineral = custom_saved_vars["mineral"]
	if(_mineral)
		mineral = SSmaterials.get_material_by_name(_mineral)

//Keep base class from overwriting loaded mineral spread
/turf/simulated/mineral/MineralSpread()
	//If we're running this on init, from a turf loaded from the save, skip
	if(!(atom_flags & ATOM_FLAG_INITIALIZED) && map_storage_loaded)
		return
	. = ..()

//Override the base one to work with stackable ore
/turf/simulated/mineral/DropMineral(var/howmany)
	if(!mineral || howmany < 1)
		return

	clear_ore_effects()
	var/obj/item/stack/ore/O = new(src, howmany, mineral.name)
	if(geologic_data && istype(O))
		geologic_data.UpdateNearbyArtifactInfo(src)
		O.geologic_data = geologic_data
	return O