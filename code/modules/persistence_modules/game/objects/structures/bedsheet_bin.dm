/obj/structure/bedsheetbin
	amount = 0
/obj/structure/bedsheetbin/filled
	amount = 20
/obj/structure/bedsheetbin/New()
	..()
	ADD_SAVED_VAR(hidden)
	ADD_SAVED_VAR(amount)
/obj/structure/bedsheetbin/Destroy()
	if(hidden)
		hidden.forceMove(get_turf(loc))
	return ..()

/obj/structure/bedsheetbin/proc/can_hide_item(obj/item/I)
	return amount && !hidden && I.w_class < ITEM_SIZE_HUGE

/obj/structure/bedsheetbin/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/bedsheet))
		if(!user.unEquip(I, src))
			return
		sheets.Add(I)
		amount++
		to_chat(user, SPAN_NOTICE("You put [I] in [src]."))
		return 1
	else if(isWrench(I))
		refund_matter()
		qdel(src)
		return 1
	else if(user.a_intent != I_HURT && can_hide_item(I))	//make sure there's sheets to hide it among, make sure nothing else is hidden in there.
		if(!user.unEquip(I, src))
			return
		hidden = I
		to_chat(user, SPAN_NOTICE("You hide [I] among the sheets."))
		return 1
	else
		return ..()

/obj/structure/bedsheetbin/attack_hand(mob/user as mob)
	if(user.a_intent != I_HURT)
		var/obj/item/weapon/bedsheet/B = take_sheet()
		if(!B)
			to_chat(user, SPAN_WARNING("\The [src] is empty!"))
			return
		add_fingerprint(user)
		B.forceMove(user.loc)
		user.put_in_hands(B)
		to_chat(user, SPAN_NOTICE("You take [B] out of [src]."))

		if(hidden)
			hidden.forceMove(user.loc)
			to_chat(user, SPAN_NOTICE("[hidden] falls out of [B]!"))
			hidden = null
	else
		return ..()

/obj/structure/bedsheetbin/proc/take_sheet()
	if(amount >= 1)
		amount--

		var/obj/item/weapon/bedsheet/B
		if(sheets.len > 0)
			B = sheets[sheets.len]
			sheets.Remove(B)

		else
			B = new /obj/item/weapon/bedsheet(loc)
		. = B
		update_icon()
	return .


