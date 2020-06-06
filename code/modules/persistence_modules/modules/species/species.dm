/datum/species
	var/tmp/stack_type = /obj/item/organ/internal/stack //stack to spawn with by default

/datum/species/proc/can_have_cortical_stack()
	return !ispath(stack_type)

// /datum/species/proc/create_organs(var/mob/living/carbon/human/H) //Handles creation of mob organs.
// 	var/obj/item/organ/internal/stack/lace
// 	for(var/obj/item/organ/organ in H.contents)
// 		if(((organ in H.organs) || (organ in H.internal_organs)) && !istype(organ, /obj/item/organ/internal/stack))
// 			qdel(organ)
// 		else if(organ in H.internal_organs)
// 			lace = organ

// 	if(lace)
// 		H.internal_organs |= lace
// 		H.internal_organs_by_name[BP_STACK] = lace
// 		if(istype(H))
// 			var/obj/item/organ/external/E = H.get_organ(lace.parent_organ)
// 			E.internal_organs |= lace
// 	else
// 		if(!H.internal_organs_by_name[BP_STACK])
// 			lace = new(H)
// 		H.internal_organs_by_name[BP_STACK] = lace
	
// 	. = ..()


