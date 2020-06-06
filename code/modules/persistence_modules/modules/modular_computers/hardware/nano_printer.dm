/obj/item/weapon/stock_parts/computer/nano_printer/New()
	..()
	ADD_SAVED_VAR(stored_paper)

/obj/item/weapon/stock_parts/computer/nano_printer/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/paper))
		var/obj/item/weapon/paper/paper = W
		if(paper.info && paper.info != "")
			to_chat(user, "You try to add \the [W] into \the [src], but paper that is not blank is not accepted.")
			return
		if(stored_paper >= max_paper)
			to_chat(user, "You try to add \the [W] into \the [src], but its paper bin is full.")
			return

		to_chat(user, "You insert \the [W] into [src].")
		qdel(W)
		stored_paper++
		return 1
	else if(istype(W, /obj/item/weapon/shreddedp))
		if(stored_paper >= max_paper)
			to_chat(user, "You try to add \the [W] into \the [src], but its paper bin is full.")
			return

		to_chat(user, "You insert \the [W] into [src].")
		qdel(W)
		stored_paper++
		return 1
	else
		return ..()