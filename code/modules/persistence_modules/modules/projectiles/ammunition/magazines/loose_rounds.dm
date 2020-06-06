//#TODO FINISH THIS!!!!!

//Represents a bunch of rounds held in a character's hand
// It gets auto-created when handling single rounds
// 
/obj/item/ammo_magazine/loose_rounds
	name = "loose rounds"
	w_class = ITEM_SIZE_SMALL
	max_ammo = 1 //The value is changed depending on what you insert into it

/obj/item/ammo_magazine/loose_rounds/after_load()
	. = ..()
	if(!length(stored_ammo))
		qdel(src) //Shouldn't exist

/obj/item/ammo_magazine/loose_rounds/should_save(datum/saver)
	. = ..()
	if(!length(stored_ammo))
		return FALSE

/obj/item/ammo_magazine/loose_rounds/dropped(mob/user)
	. = ..()
	for(var/obj/item/ammo_casing/C in stored_ammo)
		C.forceMove(user.loc)
		C.set_dir(pick(GLOB.alldirs))
	stored_ammo.Cut()
	qdel(src) //Loose rounds don't exist outside a mob's hands

/obj/item/ammo_magazine/loose_rounds/attackby(var/obj/item/I, var/mob/user)
	if(istype(I, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/C = I
		if(length(stored_ammo) < max_ammo)
			to_chat(user, SPAN_WARNING("Can't hold more [C]!"))
			return
		if(C.caliber != caliber)
			to_chat(user, SPAN_WARNING("Can't mix \the [C.caliber] [C] with \the [caliber] rounds you're holding!"))
			return
		stored_ammo += C
		C.forceMove(src)
		update_icon()
		return 1
	. = ..()

//
//OVERRIDE INSERTION INTO STORAGE ITEM
//
/obj/item/weapon/storage/attackby(var/obj/item/ammo_magazine/loose_rounds/W, mob/user)
	if(istype(W, /obj/item/ammo_magazine/loose_rounds))
		for(var/obj/item/ammo_casing/C in W.stored_ammo)
			if(can_be_inserted(C, user))
				handle_item_insertion(C, null, TRUE)
		qdel(W)
		update_icon()
		return 1
	. = ..()

//
//Overrides some of the interactions with other magazines
//
/obj/item/ammo_magazine/attackby(var/obj/item/ammo_magazine/loose_rounds/W, var/mob/user)
	if(istype(W, /obj/item/ammo_magazine/loose_rounds))
		if(W.caliber != caliber)
			to_chat(user, "<span class='warning'>[W] does not fit into [src].</span>")
			return
		if(stored_ammo.len >= max_ammo)
			to_chat(user, "<span class='warning'>[src] is full!</span>")
			return
		//Transfer the ammo to the magazine
		var/cpt = 1
		var/rnds_to_insert = max_ammo - stored_ammo.len
		while(cpt <= rnds_to_insert)
			var/obj/item/ammo_casing/C = W.stored_ammo[cpt]
			stored_ammo += C
		//Remove the transfered ammo from the list
		W.stored_ammo.Cut(1, rnds_to_insert + 1)
		update_icon()
		//If there's no more ammo, destroy the loose rounds object
		if(!length(W.stored_ammo))
			qdel(W)
		else
			W.update_icon()
		return 1
	else 
		return ..()

/obj/item/ammo_magazine/attack_hand(mob/user)
	if(user.get_inactive_hand() == src)
		if(!stored_ammo.len)
			to_chat(user, "<span class='notice'>[src] is already empty!</span>")
		else
			var/obj/item/ammo_casing/C = stored_ammo[stored_ammo.len]
			stored_ammo-=C
			user.put_in_hands(C)
			user.visible_message("\The [user] removes \a [C] from [src].", "<span class='notice'>You remove \a [C] from [src].</span>")
			update_icon()
	else
		..()