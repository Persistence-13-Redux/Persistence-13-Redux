/obj/structure/dispenser
	atom_flags = ATOM_FLAG_CLIMBABLE

/obj/structure/dispenser/empty
	oxygentanks = 0
	phorontanks = 0

/obj/structure/dispenser/New()
	. = ..()
	ADD_SAVED_VAR(oxygentanks)
	ADD_SAVED_VAR(phorontanks)
	ADD_SAVED_VAR(oxytanks)
	ADD_SAVED_VAR(platanks)

/obj/structure/dispenser/attackby(obj/item/I, mob/user)
	if(isWelder(I) && !anchored)
		var/obj/item/weapon/weldingtool/WT = I
		if(WT.remove_fuel(0,user))
			var/obj/item/stack/material/steel/new_item = new(usr.loc)
			new_item.add_to_stacks(usr)
			for (var/mob/M in viewers(src))
				M.show_message(SPAN_NOTICE("[src] is shaped into metal by [user.name] with the welding tool."), 3, SPAN_NOTICE("You hear welding."), 2)
			qdel(src)
		return
	else
		return ..()