
/obj/structure/curtain/attackby(obj/item/W as obj, mob/user as mob)
	if((isScrewdriver(W)) && (istype(loc, /turf/simulated) || anchored))
		playsound(loc, 'sound/items/Screwdriver.ogg', 100, 1)
		anchored = !anchored
		user.visible_message("<span class='notice'>[user] [anchored ? "fastens" : "unfastens"] the [src].</span>", \
								 "<span class='notice'>You have [anchored ? "fastened the [src] to" : "unfastened the [src] from"] the floor.</span>")
		return

	if(isWelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(0,user))
			var/obj/item/stack/material/plastic/new_item = new(usr.loc)
			new_item.add_to_stacks(usr)
			for (var/mob/M in viewers(src))
				M.show_message("<span class='notice'>Now slicing apart the [src]...</span>", 3, "<span class='notice'>You hear welding.</span>", 2)
		qdel(src)
		return
	return ..()