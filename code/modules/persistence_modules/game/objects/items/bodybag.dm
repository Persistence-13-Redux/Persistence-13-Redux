/obj/structure/closet/body_bag/attackby(var/obj/item/W, mob/user)
	if(istype(W, /obj/item/device/scanner/health/) && !opened)
		if(contains_body)
			var/obj/item/device/scanner/health/HA = W
			for(var/mob/living/L in contents)
				HA.afterattack(L, user, TRUE)
		else
			to_chat(user, "\The [W] reports that \the [src] is empty.")
		return
	return ..()