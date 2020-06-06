/turf/simulated/wall/New(var/newloc, var/materialtype, var/rmaterialtype, var/girder_mat, var/girder_reinf_mat)
	..()
	ADD_SAVED_VAR(paint_color)
	ADD_SAVED_VAR(stripe_color)
	ADD_SAVED_VAR(last_state)
	ADD_SAVED_VAR(construction_stage)
	ADD_SAVED_VAR(damage)
	ADD_SAVED_VAR(can_open) //For hidden doors
	ADD_SAVED_VAR(blocks_air) //For hidden doors
	ADD_SAVED_VAR(floor_type)

/turf/simulated/wall/before_save()
	. = ..()
	custom_saved_vars["material_name"] = material?.name
	custom_saved_vars["reinf_material_name"] = reinf_material?.name
	
/turf/simulated/wall/after_load()
	. = ..()
	var/_matname = custom_saved_vars["material_name"]
	if(_matname)
		material = SSmaterials.get_material_by_name(_matname)
	var/_reinfmatname = custom_saved_vars["reinf_material_name"]
	if(_reinfmatname)
		reinf_material = SSmaterials.get_material_by_name(_reinfmatname)

// /turf/simulated/wall/Initialize(mapload, materialtype, rmaterialtype, girder_mat, girder_reinf_mat)
// 	if(..() == INITIALIZE_HINT_QDEL)
// 		return INITIALIZE_HINT_QDEL
// 	return INITIALIZE_HINT_LATELOAD

// /turf/simulated/wall/LateInitialize()
// 	. = ..()
// 	if(!map_storage_loaded)
// 		update_full(TRUE, TRUE)
// 	else
// 		update_full(FALSE, FALSE) //Don't propagate on load
// 	hitsound = material.hitsound
// 	START_PROCESSING(SSturf, src) //Used for radiation.


// //Tungsten rwalls!
// /turf/simulated/wall/r_wall/tungsten
// 	reinf_material 			= new /material/tungsten
// 	material 				= new /material/tungsten
// 	// girder_material 		= new /material/tungsten
// 	// girder_reinf_material 	= new /material/tungsten

// /turf/simulated/wall/r_wall/tungsten/New(newloc, material/mat, material/r_mat, material/p_mat)
// 	. = ..(newloc, src.material, src.reinf_material, src.material) //Keeps the base ctor from being a dipshit

// /turf/simulated/wall/proc/MaxIntegrity()
// 	return material.integrity + (reinf_material ? reinf_material.integrity + (material.integrity * reinf_material.integrity / 100) : 0) + (material.integrity / 2)

// /turf/simulated/wall/proc/BruteArmor()
// 	return material.brute_armor + (reinf_material ? reinf_material.brute_armor + (material.brute_armor * reinf_material.brute_armor / 100) : 0) + (material.brute_armor / 2)

// /turf/simulated/wall/proc/BurnArmor()
// 	return material.burn_armor + (reinf_material ? reinf_material.burn_armor + (material.burn_armor * reinf_material.burn_armor / 100) : 0) + (material.burn_armor / 2)

// /turf/simulated/wall/proc/ExplosionArmor()
// 	return material.hardness + (reinf_material ? reinf_material.hardness + (material.integrity * reinf_material.hardness / 100) : 0) + (material.hardness / 2)

