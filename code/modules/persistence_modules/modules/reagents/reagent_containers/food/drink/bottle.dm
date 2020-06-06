/obj/item/weapon/reagent_containers/food/drinks/bottle/smash(var/newloc, atom/against = null)
	if(ismob(loc))
		var/mob/M = loc
		M.drop_from_inventory(src)
	. = ..()