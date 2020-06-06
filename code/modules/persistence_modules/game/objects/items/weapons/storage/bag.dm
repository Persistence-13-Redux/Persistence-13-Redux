/obj/item/weapon/storage/bag/trash
	w_class = ITEM_SIZE_HUGE

/obj/item/weapon/storage/bag/handle_item_insertion(var/W, prevent_warning = 0)
	//Handles pest mobs, creates them a mob holder and keep going
	var/obj/item/I = null
	if(istype(W, /mob/living/simple_animal))
		var/mob/living/simple_animal/A = W
		if(issmall(A) && A.holder_type)
			var/obj/item/weapon/holder/H = new A.holder_type(get_turf(A))
			I = H
	else
		I = W //If its not an animal keep going

	. = ..(I, prevent_warning)
	if(.) update_w_class()

