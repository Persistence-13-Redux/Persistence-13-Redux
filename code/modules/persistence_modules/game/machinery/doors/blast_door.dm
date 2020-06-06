/obj/machinery/door/blast
	dir = NORTH
	explosion_resistance = 25
	maxhealth = 2000

/obj/machinery/door/blast/Initialize(mapload)
	var/old_material
	if(map_storage_loaded)
		begins_closed = !density //Make sure the base code doesn't change the door state on save load
		old_material = implicit_material
	. = ..()
	if(map_storage_loaded)
		implicit_material = old_material
	if(mapload)
		queue_icon_update()
	else
		update_icon()
	

/obj/machinery/door/blast/regular/open
	icon_state = "pdoor0"

/obj/machinery/door/blast/shutters/open
	icon_state = "shutter0"
