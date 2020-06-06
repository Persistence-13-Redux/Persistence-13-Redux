/obj/item/weapon/paper_bin/empty
	icon = 'code/modules/persistence_modules/icons/obj/items/paper.dmi'
	icon_state = "paper_bin0"
	amount = 0

/obj/item/weapon/paper_bin/New()
	. = ..()
	ADD_SAVED_VAR(amount)
	ADD_SAVED_VAR(carbon_amount)
	ADD_SAVED_VAR(papers)
	ADD_SKIP_EMPTY(papers)

/obj/item/weapon/paper_bin/attackby(obj/item/weapon/i as obj, mob/user as mob)
	if(istype(i, /obj/item/weapon/paper))
		var/obj/item/weapon/paper/paper = i
		if(paper.info && paper.info != "")
			user.unEquip(i, src)
			to_chat(user, SPAN_NOTICE("You put [i] in [src]."))
			papers.Add(i)
		else
			user.unEquip(i, src)
			to_chat(user, SPAN_NOTICE("You put [i] in [src]."))
			qdel(i)
	else if(istype(i, /obj/item/weapon/paper_package))
		var/obj/item/weapon/paper_package/p = i
		to_chat(user, SPAN_NOTICE("You open \the [i] and add its papers into \the [src]."))
		amount += p.amount
		qdel(i)
	else
		return ..()