obj/structure/firedoor_assembly/New()
	. = ..()
	ADD_SAVED_VAR(wired)

obj/structure/firedoor_assembly/on_update_icon()
	if(anchored)
		icon_state = "door_anchored"
	else
		icon_state = "construction"

obj/structure/firedoor_assembly/AltClick(mob/user)
	. = ..()
	set_dir(turn(dir, 90))
