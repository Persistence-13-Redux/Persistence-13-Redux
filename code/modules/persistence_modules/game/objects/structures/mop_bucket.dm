/obj/structure/mopbucket/SetupReagents()
	..()
	create_reagents(250)

/obj/structure/mopbucket/proc/fill_from_bucket(var/obj/item/I, var/mob/user)
	if(I.reagents.total_volume >= I.reagents.maximum_volume)
		return
	if(reagents.total_volume < 1)
		to_chat(user, "<span class='warning'>[src] is out of water!</span>")
	else
		reagents.trans_to_obj(I, I.reagents.maximum_volume)
		to_chat(user, "<span class='notice'>You wet [I] in [src].</span>")
		playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
		return

/obj/structure/mopbucket/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/mop))
		fill_from_bucket(I, user)
	else if(istype(I, /obj/item/weapon/soap))
		fill_from_bucket(I, user)
	else if(istype(I, /obj/item/weapon/reagent_containers/glass/rag))
		fill_from_bucket(I, user)
	else if(istype(I, /obj/item/weapon/reagent_containers/glass))
		return //pour away but don't hit the thing
	else if(isWrench(I))
		dismantle()
	else
		return ..()

/obj/structure/mopbucket/dismantle()
	playsound(src.loc, 'sound/items/Ratchet.ogg', 75, 1)
	to_chat(usr, "<span class='notice'>You deconstruct \the [src]</span>")
	return ..()