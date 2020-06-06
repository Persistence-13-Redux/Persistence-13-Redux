/obj/structure/handrai
	mass = 15
	matter = list(MATERIAL_STEEL = 5 SHEETS)

/obj/structure/handrai/dismantle()
	unbuckle_mob()
	refund_matter()
	qdel(src)

/obj/structure/handrai/attackby(obj/item/O, mob/user)
	if(default_deconstruction_wrench(O, user))
		dismantle()
		return 1
	. = ..()
	