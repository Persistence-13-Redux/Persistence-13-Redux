/obj
	mass = 0.05	//Kg Used for calculating throw force, inertia, and possibly more things..

//Reimplement so it uses set_anchored
/obj/wrench_floor_bolts(mob/user, delay=20)
	playsound(loc, 'sound/items/Ratchet.ogg', 100, 1)
	if(anchored)
		user.visible_message("\The [user] begins unsecuring \the [src] from the floor.", "You start unsecuring \the [src] from the floor.")
	else
		user.visible_message("\The [user] begins securing \the [src] to the floor.", "You start securing \the [src] to the floor.")
	if(do_after(user, delay, src))
		if(!src) return
		to_chat(user, "<span class='notice'>You [anchored? "un" : ""]secured \the [src]!</span>")
		set_anchored(!anchored)
	return 1

/obj/proc/set_anchored(var/new_anchored)
	anchored = new_anchored
	update_icon()

/obj/proc/isanchored()
	return anchored

//Drops the material worth of the object as material sheets.
/obj/proc/refund_matter()
	for(var/key in matter)
		var/material/M = SSmaterials.get_material_by_name(key)
		if(M)
			if(!M.units_per_sheet)
				log_warning("Material [M] is missing its units_per_sheet count!")
				continue
			var/sheetamt = matter[key] / M.units_per_sheet
			M.place_sheet(get_turf(loc), sheetamt)
