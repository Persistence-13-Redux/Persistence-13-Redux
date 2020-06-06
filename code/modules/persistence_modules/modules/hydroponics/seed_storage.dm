/datum/seed_pile/New(var/obj/item/seeds/O, var/ID)
	..()
	ADD_SAVED_VAR(name)
	ADD_SAVED_VAR(amount)
	ADD_SAVED_VAR(seed_type)
	ADD_SAVED_VAR(seeds)
	ADD_SAVED_VAR(ID)

/obj/machinery/seed_storage
	var/seeds_initialized = 0 // Map-placed ones break if seeds are loaded right at the start of the round, so we do it on the first interaction
	scanner = list("stats", "produce", "soil", "temperature", "light") // What properties we can view

/obj/machinery/seed_storage/New()
	. = ..()
	ADD_SAVED_VAR(piles)

/obj/machinery/seed_storage/after_load()
	. = ..()
	seeds_initialized = TRUE //Always force this after load, since we don't want it to init again

//Prevent the base class from trying to spawn starting seeds again
/obj/machinery/seed_storage/Initialize(var/mapload)
	var/old_starting_seeds
	if(map_storage_loaded)
		old_starting_seeds = starting_seeds
		starting_seeds = null
	. = ..()
	if(map_storage_loaded)
		starting_seeds = old_starting_seeds

/obj/machinery/seed_storage/interact(mob/user as mob)
	if (!seeds_initialized)
		if(!map_storage_loaded)
			for(var/typepath in starting_seeds)
				var/amount = starting_seeds[typepath]
				if(isnull(amount)) amount = 1

				for (var/i = 1 to amount)
					var/O = new typepath
					add(O)
		seeds_initialized = TRUE
	. = ..()

