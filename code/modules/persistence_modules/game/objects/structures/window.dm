/obj/structure/window
	var/ini_dir = null
	//hitsound = 'sound/effects/Glasshit.ogg'
	//sound_destroyed = "shatter"

/obj/structure/window/New(Loc, start_dir=null, constructed=0, var/new_material, var/new_reinf_material)
	..()
	//player-constructed windows
	if (constructed)
		construction_state = 0
	ADD_SAVED_VAR(state)
	ADD_SAVED_VAR(init_material)
	ADD_SAVED_VAR(init_reinf_material)
	ADD_SAVED_VAR(reinf_basestate)

/obj/structure/window/Initialize(mapload, start_dir=null, constructed=0, var/new_material, var/new_reinf_material)
	//The base init proc force set the health on init, replacing anything loaded from the save
	var/old_health = health
	. = ..()
	if(map_storage_loaded)
		health = old_health
// 	return INITIALIZE_HINT_LATELOAD

// /obj/structure/window/LateInitialize()
// 	. = ..()
// 	update_nearby_tiles(need_rebuild=1)