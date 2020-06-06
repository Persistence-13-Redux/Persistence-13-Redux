/obj/structure/fountain/mundane/attack_hand()
	return examine(usr)

/obj/structure/fountain/mundane/attackby(obj/item/O, mob/user)
	if(default_deconstruction_wrench(O, user, 16 SECONDS))
		to_chat(user, SPAN_NOTICE("You dismantle \the [src]!"))
		dismantle()
		return 1
	return ..()

/obj/structure/fountain/mundane/dismantle()
	refund_matter()
	qdel(src)
	