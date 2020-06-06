/datum/export_order
	var/name = "" // summary of the order, should be set on runtime
	var/required = 0 // how many items the order will take
	var/supplied = 0
	var/id = 0
	var/typepath // should be the typepath of the item we're looking for..
	var/parent_typepath
	var/looking_name = ""
	var/rate = 0
	var/order_type = ""

/datum/export_order/proc/fill(var/obj/structure/closet/crate)
	var/filled = 0
	var/overfilled = 0
	var/list/filling = list()
	for(var/obj/A in crate.contents)
		if(istype(A, /obj/item/weapon/paper/export))
			filling |= A
			continue
		if(!istype(A, typepath) && (A.name != looking_name || !istype(A, parent_typepath)))
			message_admins("fill failed due to invalid object [A.name]")
			return 0
		if(filled >= (required - supplied))
			overfilled = 1
		else
			filling |= A
			filled++
	if(overfilled)
		for(var/atom/movable/A in crate.contents)
			if(A in filling)
				continue
			A.loc = crate.loc
	if(filled)
		crate.loc = null
		playsound(crate.loc,'sound/effects/teleport.ogg',40,1)
		qdel(crate)
		supplied += filled
		. = filled*rate
		spawn(1 SECOND)
			if(supplied >= required)
				SSsupply.close_order(src)

/datum/export_order/static

/datum/export_order/static/fill(var/obj/structure/closet/crate)
	var/filled = 0
	for(var/obj/A in crate.contents)
		if(istype(A, /obj/item/weapon/paper/export))
			continue
		if(!istype(A, typepath) && A.name != looking_name)
			message_admins("fill failed due to invalid object [A.name]")
			return 0
		filled++

	if(filled)
		. = crate.Value()
		crate.loc = null
		playsound(crate.loc,'sound/effects/teleport.ogg',40,1)
		qdel(crate)


/datum/export_order/stack

/datum/export_order/stack/fill(var/obj/structure/closet/crate)
	if(!crate)
		return 0
	var/filled = 0
	var/overfilled = 0
	var/list/filling = list()
	for(var/obj/A in crate.contents)
		if(istype(A, /obj/item/weapon/paper/export))
			filling |= A
			continue
		if(!istype(A, typepath) && A.name != looking_name)
			return 0
		var/obj/item/stack/stack = A
		var/max = (required - (supplied+filled))
		if(max < stack.amount)
			stack.amount -= max
			filled += max
		else
			filled += stack.amount
		if(filled >= (required - supplied))
			overfilled = 1
		else
			filling |= A
			filled++
	if(overfilled)
		for(var/atom/movable/A in crate.contents)
			if(A in filling)
				continue
			A.loc = crate.loc
	if(filled)
		crate.loc = null
		playsound(crate.loc,'sound/effects/teleport.ogg',40,1)
		qdel(crate)
		supplied += filled
		. = filled*rate
		spawn(1 SECOND)
			if(supplied >= required)
				SSsupply.close_order(src)
