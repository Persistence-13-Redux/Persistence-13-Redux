/datum/storage_ui/default/should_save = FALSE

/obj/item/weapon/storage/make_exact_fit()
	if(map_storage_loaded) //Don't do it after loading!!!!!
		return
	. = ..()

/obj/item/weapon/storage/internal/New(obj/item/MI)
	if(MI)
		master_item = MI
		loc = master_item
		name = master_item.name
		verbs -= /obj/item/verb/verb_pickup	//make sure this is never picked up.
		..()
	ADD_SAVED_VAR(master_item)
	
/obj/item/weapon/storage/internal/after_load()
	// storage_ui = new storage_ui(src)
	// prepare_ui()
	if(master_item)
		loc = master_item
		name = master_item.name
		verbs -= /obj/item/verb/verb_pickup	//make sure this is never picked up.
		. = ..()

/obj/item/weapon/storage/internal/pockets/after_load()
	if(master_item)
		loc = master_item
		name = master_item.name
		if(istype(loc, /obj/item/clothing/suit/storage))
			var/obj/item/clothing/suit/storage/coat = loc
			if(coat)
				coat.pockets = src
		if(istype(loc, /obj/item/clothing/accessory/storage))
			var/obj/item/clothing/accessory/storage/web = loc
			if(web)
				web.hold = src
		. =..()

/obj/item/weapon/evidencebag/New()
	. = ..()
	ADD_SAVED_VAR(stored_item)
