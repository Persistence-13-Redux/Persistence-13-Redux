/obj/item/weapon/folder/fire_act(datum/gas_mixture/air, temperature, volume)
	new /obj/effect/decal/cleanable/ash(src.loc)
	qdel(src)
	return
