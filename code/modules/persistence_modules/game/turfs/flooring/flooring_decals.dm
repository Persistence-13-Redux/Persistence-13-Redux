/obj/effect/floor_decal
	anchored = TRUE

/obj/effect/floor_decal/New(var/newloc, var/newdir, var/newcolour, var/newappearance)
	..()
	ADD_SAVED_VAR(supplied_dir)
	ADD_SAVED_VAR(detail_overlay)
	ADD_SAVED_VAR(detail_color)
	ADD_SAVED_VAR(alpha)
	ADD_SAVED_VAR(color)
	ADD_SAVED_VAR(plane)
	ADD_SAVED_VAR(layer)
