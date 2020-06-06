/obj/structure/railing/Initialize()
	var/old_health = health
	. = ..()
	if(map_storage_loaded)
		health = old_health //Make sure the base class doesn't mess up our health