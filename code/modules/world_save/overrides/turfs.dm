/turf
	map_storage_saved_vars = "density;icon_state;name;pixel_x;pixel_y;contents;dir"
	skip_empty = "contents;saved_decals;req_access;req_access_personal_list;req_one_access;req_one_access_business_list"


/turf/after_load()
	..()
	//decals = saved_decals.Copy()
	queue_icon_update()
	if(dynamic_lighting)
		lighting_build_overlay()
	else
		lighting_clear_overlay()

/turf/space/map_storage_saved_vars = "contents"
/turf/space/after_load()
	..()
	for(var/atom/movable/lighting_overlay/overlay in contents)
		overlay.loc = null
		qdel(overlay)
/turf/make_air()
	if(map_storage_loaded)
		initial_gas = list()
	. = ..()