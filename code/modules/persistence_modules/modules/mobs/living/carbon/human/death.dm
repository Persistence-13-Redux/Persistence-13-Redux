/mob/living/carbon/human/gib()
	//Get rid of the stumps first so we don't end up with invisible stumps on the floor..
	for(var/obj/item/I in src)
		if(istype(I, /obj/item/organ/external/stump))
			var/obj/item/organ/external/stump/S = I
			S.removed()
			S.loc = null
			qdel(S) //Don't drop stumps!
			continue
	return ..()
