/obj/item/weapon/storage/ore
	can_hold = list(/obj/item/stack/ore, /obj/item/stack/material_dust)

/obj/item/weapon/storage/ore/handle_item_insertion(var/obj/item/W, var/prevent_warning = 0, var/NoUpdate = 0)
	if(!istype(W))
		return 0
	if(istype(W.loc, /mob))
		var/mob/M = W.loc
		M.remove_from_mob(W)
	W.forceMove(src)
	if(istype(W,/obj/item/stack))
		var/obj/item/stack/st = W
		st.drop_to_stacks(src)
	W.on_enter_storage(src)
	if(usr)
		add_fingerprint(usr)

		if(!prevent_warning)
			for(var/mob/M in viewers(usr, null))
				if (M == usr)
					to_chat(usr, "<span class='notice'>You put \the [W] into [src].</span>")
				else if (M in range(1)) //If someone is standing close enough, they can tell what it is... TODO replace with distance check
					M.show_message("<span class='notice'>\The [usr] puts [W] into [src].</span>")
				else if (W && W.w_class >= ITEM_SIZE_NORMAL) //Otherwise they can only see large or normal items from a distance...
					M.show_message("<span class='notice'>\The [usr] puts [W] into [src].</span>")

		if(!NoUpdate)
			update_ui_after_item_insertion()
	update_icon()
	return 1