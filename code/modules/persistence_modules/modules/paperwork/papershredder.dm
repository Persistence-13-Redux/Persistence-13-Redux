/obj/machinery/papershredder
	mass = 5
/obj/machinery/papershredder/New()
	. = ..()
	ADD_SAVED_VAR(paperamount)

/obj/machinery/papershredder/attackby(var/obj/item/W, var/mob/user)
	if(isWelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(0,user))
			var/obj/item/stack/material/steel/new_item = new(usr.loc)
			new_item.add_to_stacks(usr)
			for (var/mob/M in viewers(src))
				M.show_message("<span class='notice'>[src] is shaped into metal by [user.name] with the weldingtool.</span>", 3, "<span class='notice'>You hear welding.</span>", 2)
			qdel(src)
		return
	else
		return ..()
	
/obj/item/weapon/shreddedp/FireBurn()
	var/mob/living/M = loc
	if(istype(M))
		M.drop_from_inventory(src)
	..()

/obj/item/weapon/shreddedp/New()
	..()
	ADD_SAVED_VAR(color)

/obj/item/weapon/shreddedp/Initialize()
	. = ..()
	if(!map_storage_loaded)
		if(prob(65)) color = pick("#bababa","#7f7f7f")