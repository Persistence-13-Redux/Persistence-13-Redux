/obj/structure/stasis_cage/New()
	. = ..()
	ADD_SAVED_VAR(contained)
	ADD_SKIP_EMPTY(contained)

/obj/structure/stasis_cage/attackby(obj/item/O, mob/user)
	if(default_deconstruction_wrench(O, user) && src)
		dismantle()
		return 1
	return ..()
