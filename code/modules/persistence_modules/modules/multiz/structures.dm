/obj/structure/ladder
	var/dnr = 0

/obj/structure/ladder/New()
	. = ..()
	ADD_SAVED_VAR(allowed_directions)

/obj/structure/ladder/Initialize()
	var/old_allowed_dir
	if(map_storage_loaded)
		old_allowed_dir = allowed_directions
		allowed_directions = 0 //Make sure the base class code doesn't run
	. = ..()
	if(map_storage_loaded)
		allowed_directions = old_allowed_dir
	link_ladders()
	queue_icon_update()

/obj/structure/ladder/proc/link_ladders()
	// the upper will connect to the lower
	for(var/obj/structure/ladder/L in GetBelow(src))
		log_debug("Tring to link [src]([x][y][z]) down with [L]([L.x],[L.y],[L.z])")
		log_debug("Linked!")
		target_down = L
		allowed_directions |= DOWN
		L.target_up = src
		L.allowed_directions |= UP
		return

/obj/structure/stairs
	var/tmp/was_already_saved = FALSE //In order to fix multi-tiles objects we gotta make sure only the base turf of the object saves it

/obj/structure/stairs/should_save(datum/saver)
	. = ..()
	if(!.)
		return FALSE
	var/turf/T = saver
	if(istype(saver))
		return T == get_turf(src) //only save if we're on the "base" turf on which the stairs rest on
	return FALSE

// type paths to make mapping easier.
/obj/structure/stairs/north
	dir = NORTH
	bound_height = 64
	bound_width = 32
	bound_y = -32
	pixel_y = -32

/obj/structure/stairs/south
	dir = SOUTH
	bound_height = 64
	bound_width = 32

/obj/structure/stairs/east
	dir = EAST
	bound_width = 64
	bound_height = 32
	bound_x = -32
	pixel_x = -32

/obj/structure/stairs/west
	dir = WEST
	bound_width = 64
	bound_height = 32