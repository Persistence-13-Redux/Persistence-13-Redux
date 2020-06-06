/obj/structure/door_assembly
	var/allow_keypad = 	 FALSE // accepts keypad electronics
	var/allow_personal = FALSE // accepts personal electronics

/obj/structure/door_assembly/New()
	..()
	update_state()
	ADD_SAVED_VAR(base_name)
	ADD_SAVED_VAR(glass)
	ADD_SAVED_VAR(created_name)
	ADD_SAVED_VAR(state)
	ADD_SAVED_VAR(electronics)
	ADD_SAVED_VAR(glass)
	ADD_SAVED_VAR(created_name)
	ADD_SAVED_VAR(door_color)
	ADD_SAVED_VAR(stripe_color)
	ADD_SAVED_VAR(symbol_color)

/obj/structure/door_assembly/door_assembly_keyp
 	base_name = "Keypad Airlock"
 	glass = -1
 	allow_keypad = TRUE
 	airlock_type = "/keypad"

/obj/structure/door_assembly/door_assembly_personal
	base_name = "Personal Airlock"
	glass = -1
	allow_personal = TRUE
	airlock_type = "/personal"


/obj/structure/door_assembly/multi_tile/New()
	..()
	ADD_SAVED_VAR(width)

/obj/structure/door_assembly/multi_tile/Move()
	. = ..()
	update_icon()

//Make sure we don't save twice!
/obj/structure/door_assembly/multi_tile/should_save(var/datum/caller)
	if(caller == loc)
		return ..()
	else
		return 0
	return ..()

/obj/structure/door_assembly/multi_tile/on_update_icon()
	if(dir in list(EAST, WEST))
		bound_width = world.icon_size
		bound_height = width * world.icon_size
	else
		bound_width = width * world.icon_size
		bound_height = world.icon_size
	..()


/obj/structure/door_assembly/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/airlock_electronics) && state == 1)
		if((istype(W, /obj/item/weapon/airlock_electronics/keypad_electronics) && !allow_keypad) || (istype(W, /obj/item/weapon/airlock_electronics/personal_electronics) && !allow_personal))
			to_chat(user, "<span class='warning'>\The [src] doesn't accept that type of airlock electronics!</span>")
			return 0
	return ..()
