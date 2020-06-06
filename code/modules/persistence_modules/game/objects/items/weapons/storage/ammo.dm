// ----------------------------- //A NOTE ON THESE AMMO BOXES! They are kinda messy, clean them up if you get the chance.
//          Ammo boxes
// -----------------------------

/obj/item/weapon/storage/ammobox
	name = "ammo box"
	desc = "An ammo box. Able to hold all sorts of ammunition types. Needs a transport box to place ammunition into it."
	max_storage_space = 100
	max_w_class = ITEM_SIZE_SMALL
	w_class = ITEM_SIZE_LARGE
	can_hold = list(/obj/item/ammo_casing/)
	icon = 'icons/obj/ammo.dmi'
	icon_state = "ammobox"
	slot_flags = SLOT_BACK
	allow_quick_empty = 1
	matter = list(MATERIAL_STEEL = 10000)

/obj/item/weapon/storage/ammobox/attackby(var/obj/item/O as obj, var/mob/user as mob)

	if(istype(O,/obj/item/weapon/storage/ammotbox))
		var/failed = 1
		for(var/obj/item/G in O.contents)
			failed = 0

			if(!can_be_inserted(G, user, FALSE))
				break

			handle_item_insertion(G, TRUE, FALSE)

		if(failed)
			to_chat(user, "Nothing in \the [O] is usable.")
			return 1

		if(!O.contents.len)
			to_chat(user, "You empty \the [O] into \the [src].")
		else
			to_chat(user, "You fill \the [src] from \the [O].")

		src.updateUsrDialog()
		return 0

	if(istype(O,/obj/item/ammo_magazine))
		var/obj/item/ammo_magazine/mag = O
		if(!src.contents.len)
			to_chat(user, "[src] is empty.")
			return
		if(mag.max_ammo <= mag.stored_ammo.len)
			to_chat(user, "[O] is full.")
			return
		var/failed = 1
		for(var/obj/item/G in src.contents)
			if(!istype(G, mag.ammo_type))
				continue
			if(do_after(user, 10, mag))
				failed = 0
				G.loc = mag
				mag.stored_ammo |= G
				to_chat(user, "You load a casing into [O].")
				playsound(src.loc, 'sound/weapons/empty.ogg', 2, 1)
				mag.update_icon()
				if(mag.stored_ammo.len >= mag.max_ammo)
					to_chat(user, "You filled \the [O].")
					break
			else
				failed = 0
				return
		if(failed)
			to_chat(user, "There was nothing suitable to load into \the [O] in \the [src].")

			src.updateUsrDialog()
			return 0

/obj/item/weapon/storage/ammotbox
	name = "ammo transport box"
	desc = "This box holds all sorts of ammunition to fill larger ammo boxes."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "smallbox"
	max_storage_space = 50
	max_w_class = ITEM_SIZE_SMALL
	w_class = ITEM_SIZE_NORMAL
	can_hold = list(/obj/item/ammo_casing/)
	allow_quick_gather = 1
	allow_quick_empty = 1
	use_to_pickup = 1
	matter = list(MATERIAL_STEEL = 5000)

/obj/item/weapon/storage/ammobox/big
	name = "big ammo box"
	desc = "A large ammo box. It comes with a leather strap. Needs a transport box to transfer ammo into it."
	max_storage_space = 600
	max_w_class = ITEM_SIZE_SMALL
	w_class = ITEM_SIZE_HUGE
	can_hold = list(/obj/item/ammo_casing/)
	icon = 'icons/obj/ammo.dmi'
	icon_state = "bigammobox"
	slot_flags = SLOT_BACK
	allow_quick_empty = 1
	matter = list(MATERIAL_STEEL = 30000)
