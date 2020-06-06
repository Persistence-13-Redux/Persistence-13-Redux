/obj/item/weapon/paper_bundle/fire_act(datum/gas_mixture/air, temperature, volume)
	new /obj/effect/decal/cleanable/ash(src.loc)
	qdel(src)
	return

/obj/item/weapon/paper_bundle/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/stack/tape_roll))
		return 0
	return ..()