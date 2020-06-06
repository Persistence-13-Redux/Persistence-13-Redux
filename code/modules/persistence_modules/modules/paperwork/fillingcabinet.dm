/obj/structure/filingcabinet/attackby(obj/item/P as obj, mob/user as mob)
	if(isWelder(P))
		var/obj/item/weapon/weldingtool/WT = P
		if(WT.remove_fuel(0,user))
			var/obj/item/stack/material/steel/new_item = new(usr.loc)
			new_item.add_to_stacks(usr)
			for (var/mob/M in viewers(src))
				M.show_message("<span class='notice'>[src] is shaped into metal by [user.name] with the weldingtool.</span>", 3, "<span class='notice'>You hear welding.</span>", 2)
			qdel(src)
		return
	else
		return ..()