/obj/structure/fitness/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(isWrench(W))
		if(anchored)
			anchored = 0
			user.visible_message("[user] unsecures [src] from the floor.", "You unsecure [src] from the floor.")
	else
		anchored = 1
		user.visible_message("[user] secures [src] to the floor.", "You secure [src] to the floor.")
		playsound(loc, 'sound/items/Ratchet.ogg', 100, 1)
	return ..()

/obj/structure/fitness/punchingbag/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(isWirecutter(W))
		to_chat(user, "<span class='notice'>You take apart \the [src].</span>")
		new/obj/item/stack/material/plastic(get_turf(src))
		qdel(src)
		return 1
	return ..()

/obj/structure/fitness/weightlifter
	mass = 250

/obj/structure/fitness/weightlifter/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(isWelder(W))
		to_chat(user, "<span class='notice'>You take apart \the [src].</span>")
		new/obj/item/stack/material/steel(get_turf(src))
		qdel(src)
		return 1
	return ..()