//Make sure the base class doesn't overwrite our saved stuff
/obj/item/clothing/suit/storage/Initialize()
	var/old_pockets = pockets
	. = ..()
	if(map_storage_loaded)
		pockets = old_pockets