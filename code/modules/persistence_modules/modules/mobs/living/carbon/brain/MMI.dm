/obj/item/device/mmi/New()
	. = ..()
	ADD_SAVED_VAR(locked)
	ADD_SAVED_VAR(brainmob)
	ADD_SAVED_VAR(brainobj)

/obj/item/device/mmi/get_mob()
	return ismob(loc)? loc : null
