/obj/item/seeds/New()
	. = ..()
	ADD_SAVED_VAR(seed_type)
	ADD_SAVED_VAR(seed)
	ADD_SAVED_VAR(modified)

/obj/item/seeds/after_load()
	..()
	update_seed()

//Prevent base class from overwriting our loaded vars
/obj/item/seeds/random/Initialize()
	var/old_seed = seed
	. = ..()
	if(map_storage_loaded)
		seed = old_seed
		seed_type = seed.name


