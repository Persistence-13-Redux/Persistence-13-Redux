/mob/living/silicon/robot/proc/add_lace_action()
	for(var/datum/action/lace/laceac in actions)
		return 1
	if(mmi && mmi.brainobj)
		var/datum/action/lace/laceaction = new(mmi.brainobj)
		laceaction.Grant(src)

/mob/living/silicon/robot/Initialize()
	. = ..()
	verbs -= /mob/living/silicon/robot/verb/Namepick

/mob/living/silicon/robot/proc/choose_icon_new(var/icon)
	icon_state = icon

/mob/living/silicon/robot/allowed(mob/M)
	//check if it doesn't require any access at all
	if(check_access(null))
		return 1
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		//if they are holding or wearing a card that has access, that works
		if(check_access(H.get_active_hand()) || check_access(H.wear_id))
			return 1
	else if(istype(M, /mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = M
		if(check_access(R.get_active_hand()) || istype(R.get_active_hand(), /obj/item/weapon/card/robot))
			return 1
	return 0

/mob/living/silicon/robot/check_access(obj/item/weapon/card/id/I)
	return has_access(req_access, I.access)

/mob/living/silicon/robot/after_load()
	if(istype(mmi, /obj/item/device/mmi/lmi))
		add_lace_action()
	return ..()

/mob/living/silicon/robot/get_stack()
	if(istype(mmi, /obj/item/device/mmi/lmi))
		return mmi.brainobj
	return null

/mob/living/silicon/robot/verb/CoverLock()
	set category = "Robot Commands"
	set name = "Toggle Cover Lock"
	if(opened)
		to_chat(src, "You cant lock your cover when its open.")
		return
	if(locked)
		to_chat(src, "You unlock your cover panel.")
		locked = 0
	else
		locked = 1
		to_chat(src, "You lock your cover panel.")
		