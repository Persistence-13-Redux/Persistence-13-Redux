//Lets fight with the base class to keep the saved value on map load
/obj/item/device/suit_cooling_unit/Initialize()
	var/oldcell = cell
	. = ..()
	if(map_storage_loaded)
		QDEL_NULL(cell)
		cell = oldcell
		cell.forceMove(src)