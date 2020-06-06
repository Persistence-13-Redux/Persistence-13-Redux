/obj/structure/grille/New()
	..()
	ADD_SAVED_VAR(init_material)

/obj/structure/grille/Initialize(mapload, var/new_material)
	var/old_mat = material
	var/old_health = health
	. = ..()
	if(map_storage_loaded)
		material = old_mat
		health = old_health