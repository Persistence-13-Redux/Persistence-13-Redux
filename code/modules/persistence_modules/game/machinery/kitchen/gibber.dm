/obj/machinery/gibber/New()
	..()
	ADD_SAVED_VAR(dirty)
	ADD_SAVED_VAR(occupant)
	ADD_SKIP_EMPTY(occupant)

/obj/machinery/gibber/SetupReagents()
	. = ..()
	create_reagents(200)

/obj/machinery/gibber/attackby(var/obj/item/W, var/mob/user)
	if(!operating)
		return
	
	if(istype(W, /obj/item/organ))
		if(!user.unEquip(W))
			return
		if(W.reagents && W.reagents.get_master_reagent())
			W.reagents.trans_to_holder(src.reagents, W.reagents.total_volume) //Extract the juices!
		if(LAZYLEN(W.matter))
			//Stockpile this crap
			for(var/key in W.matter)
				src.matter[key] += W.matter[W]
				//If we got enough for a sheet barf it out
				if(src.matter[key] >= SHEET_MATERIAL_AMOUNT)
					var/material/mat = SSmaterials.get_material_by_name(key)
					if(mat)
						mat.place_sheet(get_turf(src), round(src.matter[key] / SHEET_MATERIAL_AMOUNT))

		qdel(W)
		user.visible_message("<span class='danger'>\The [user] feeds \the [W] into \the [src], obliterating it.</span>")
		return TRUE
	else if(W.is_open_container() && W.reagents && W.reagents.get_free_space())
		reagents.trans_to_obj(W, W.reagents.get_free_space())
		user.visible_message("[user] empties \the [src] into \the [W].", "You empty \the [src]'s content into \the [W].")
		return FALSE //no resolve attack
	else
		return ..()