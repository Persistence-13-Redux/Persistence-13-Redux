/mob/living/silicon/robot/show_laws(var/everyone = 0)
	if(istype(mmi, /obj/item/device/mmi/lmi))
		to_chat(src, "You have no laws, as your neural lace drives the cyborg body.")
		return
	return ..()

/mob/living/silicon/robot/robot_checklaws()
	if(istype(mmi, /obj/item/device/mmi/lmi))
		to_chat(src, "You have no laws as your lace drives the cyborg body.")
		return
	return ..()
