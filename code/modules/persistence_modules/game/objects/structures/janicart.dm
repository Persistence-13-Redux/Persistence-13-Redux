/obj/structure/janitorialcart/New()
	..()
	ADD_SAVED_VAR(mybag)
	ADD_SAVED_VAR(mymop)
	ADD_SAVED_VAR(myspray)
	ADD_SAVED_VAR(myreplacer)
	ADD_SAVED_VAR(signs)

/obj/structure/janitorialcart/SetupReagents()
	. = ..()
	create_reagents(500)

/obj/structure/janitorialcart/after_load()
	..()
	queue_icon_update()

/obj/structure/janitorialcart/Destroy()
	mybag = null
	mymop = null
	myspray = null
	myreplacer = null
	return ..()

/obj/structure/janitorialcart/proc/fill_from_bucket(var/obj/item/I, var/mob/user)
	if(I.reagents.total_volume >= I.reagents.maximum_volume)
		return
	if(reagents.total_volume < 1)
		to_chat(user, "<span class='warning'>[src] is out of water!</span>")
	else
		reagents.trans_to_obj(I, I.reagents.maximum_volume)
		to_chat(user, "<span class='notice'>You wet [I] in [src].</span>")
		playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
		return

/obj/structure/janitorialcart/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/soap))
		fill_from_bucket(I, user)
	else if(istype(I, /obj/item/weapon/reagent_containers/glass/rag))
		fill_from_bucket(I, user)
	else if(istype(I, /obj/item/weapon/mop))
		fill_from_bucket(I, user)
	else
		return ..()
	
