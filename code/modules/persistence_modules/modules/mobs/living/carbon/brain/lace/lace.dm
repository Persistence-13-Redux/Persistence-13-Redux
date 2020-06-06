/*
	The lacemob is exactly the same as the brainmob
	The only difference is the icon, and some extra details it contains.
*/
/mob/living/carbon/brain/lace
	name = "stack"
	use_me = 0 //Can't use the me verb, it's a freaking immobile brain
	icon = 'icons/obj/surgery.dmi'
	icon_state = "cortical-stack"
	default_language = LANGUAGE_HUMAN_EURO
	var/teleport_time = 0 // time when you can teleport back to nexus
	var/tmp/datum/action/lace_storage/tmp_storage_action
	var/tmp/datum/action/lace/laceaction //Need to keep the reference, otherwise removing it is really a pain in the ass

/mob/living/carbon/brain/lace/get_stack()
	return istype(container, /obj/item/organ/internal/stack) ? container : null

/mob/living/carbon/brain/lace/New(loc)
	..()
	laceaction = new(container)
	laceaction.Grant(src)

/mob/living/carbon/brain/lace/after_load()
	. = ..()
	//When a lace + lacemob is put in a lmi, the lacemob is moved into the lmi itself from the lace.
	// So we don't want to try to access the container as if it was a lace, because its not.
	if(istype(loc, /obj/item/device/mmi/lmi))
		var/obj/item/device/mmi/lmi/C = loc
		C.brainmob = src
		//Then make sure the container is set to the actual stack organ
		var/obj/item/organ/internal/stack/ST = locate() in loc
		if(ST)
			ST.brainmob = src
			container = ST
	else if(istype(container, /obj/item/organ/internal/stack))
		var/obj/item/organ/internal/stack/ST = container
		ST.brainmob = src
	for(var/datum/action/action in actions)
		action.SetTarget(container)

	// if(container2)
	// 	container2.loc = loc
	// 	loc = container
	// 	if(client)
	// 		client.perspective = EYE_PERSPECTIVE
	// 		client.eye = container
	// else if(container)
	// 	container.loc = loc
	// 	loc = container
	// 	if(client)
	// 		client.perspective = EYE_PERSPECTIVE
	// 		client.eye = container

/mob/living/carbon/brain/lace/Initialize()
	. = ..()
	update_action_buttons()
	queue_icon_update()

/mob/living/carbon/brain/lace/Destroy()
	if(laceaction)
		laceaction.Remove(src) //Make sure the lace action is cleared of any references
	if(key)				//If there is a mob connected to this thing. Have to check key twice to avoid false death reporting.
		if(stat!=DEAD)	//If not dead.
			death(1)	//Brains can die again. AND THEY SHOULD AHA HA HA HA HA HA
		if(tmp_storage_action)
			tmp_storage_action.Remove(src) //remove the old actions references plzthx
		ghostize()		//Ghostize checks for key so nothing else is necessary.
	QDEL_NULL(tmp_storage_action)
	QDEL_NULL(laceaction)
	log_debug("[src] \ref[src], inside [loc] \ref[loc] was destroyed.")
	return ..()

/mob/living/carbon/brain/lace/add_lace_action()
	if(!loc)
		return
	var/obj/item/device/mmi/lmi/L = loc
	if(!istype(L))
		return
	if(locate(/datum/action/lace) in actions)
		return
	if(L && L.brainobj)
		var/datum/action/lace/laceaction = new(Target = L.brainobj)
		laceaction.Grant(src)