/obj/item/weapon/reagent_containers/food/snacks/grown/New(newloc,planttype)
	..()
	ADD_SAVED_VAR(plantname)
	ADD_SAVED_VAR(seed)
	ADD_SAVED_VAR(potency)

/obj/item/weapon/reagent_containers/food/snacks/grown/SetupReagents()
	. = ..()
	fill_reagents()

/obj/item/weapon/reagent_containers/food/snacks/grown/Initialize()
	if(!map_storage_loaded)
		//Only get plant type from SSPlant if we're newly created. Otherwise keep our stored properties
		if(!SSplants)
			log_error("<span class='danger'>Plant controller does not exist and [src] requires it. Aborting.</span>")
			return INITIALIZE_HINT_QDEL
		seed = SSplants.seeds[plantname]
	if(!seed)
		log_error("[src]\ref[src] at loc [loc]([x], [y], [z]) didn't have a seed when initialized!")
		return INITIALIZE_HINT_QDEL
	. = ..() //SetupReagents is called in the base class, and it calls fill_reagents, which needs the seed to be setup!
	SetName("[seed.seed_name]")
	trash = seed.get_trash_type()
	if(!dried_type)
		dried_type = type

	queue_icon_update()

/obj/item/weapon/reagent_containers/food/snacks/grown/fill_reagents()
	if(!seed)
		log_error("[src]\ref[src] had no seed when reagents were intialized!")
		return
	. = ..()