/obj/item/weapon/paper
	var/info_links_fixed

/obj/item/weapon/paper/New()
	..()
	ADD_SAVED_VAR(info)
	ADD_SAVED_VAR(info_links)
	ADD_SAVED_VAR(stamps)
	ADD_SAVED_VAR(fields)
	ADD_SAVED_VAR(free_space)
	ADD_SAVED_VAR(stamped)
	ADD_SAVED_VAR(ico)
	ADD_SAVED_VAR(last_modified_ckey)
	ADD_SAVED_VAR(age)
	ADD_SAVED_VAR(metadata)

/obj/item/weapon/paper/after_load()
	info_links = replacetext(info_links,"***MY_REF***","\ref[src]")
	update_icon()
	..()

/obj/item/weapon/paper/Write(savefile/f)
	var/proper_links = info_links
	info_links = replacetext(info_links,"\ref[src]","***MY_REF***")
	StandardWrite(f)
	info_links = proper_links

/obj/item/weapon/paper/fire_act(datum/gas_mixture/air, temperature, volume)
	new /obj/effect/decal/cleanable/ash(src.loc)
	qdel(src)
	return

/obj/item/weapon/paper/attackby(obj/item/weapon/P as obj, mob/user as mob)
	if(istype(P, /obj/item/stack/tape_roll))
		var/obj/item/stack/tape_roll/tape = P
		tape.stick(src, user)
		return
	else
		return ..()


