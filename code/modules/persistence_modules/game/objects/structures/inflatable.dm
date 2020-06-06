/obj/structure/inflatable/attackby(obj/item/stack/W, mob/user)
	if(istype(W) && health < initial(health) - 3)
		if(taped)
			to_chat(user, SPAN_NOTICE("\The [src] can't be patched any more with \the [W]!"))
			return TRUE
		else
			taped = TRUE
			to_chat(user, SPAN_NOTICE("You patch some damage in \the [src] with \the [W]!"))
			take_damage(-3)
			return TRUE
	return ..()

/obj/item/weapon/storage/briefcase/inflatable/empty
	startswith = null
