/obj/item/weapon/hand_labeler/afterattack(atom/A, mob/user as mob, proximity)
	if(!proximity)
		return
	if(!mode)
		if(has_extension(A, /datum/extension/labels))
			remove_extension(A, /datum/extension/labels)
			user.visible_message("<span class='notice'>[user] removes the label from [A].</span>", \
							 	"<span class='notice'>You remove the label from [A].</span>")
		
		return
	return ..()


/obj/item/weapon/hand_labeler/admin_delabeler
	name = "ADMIN bluespace delabeler"
	desc = "After the infamous 'Ligger Incident', Nanotrasen issued this high-powered bluespace delabeler to special response teams. It will delabel not just the target object, but anything else in the sector that bears the same label."
	icon_state = "labeler0"

/obj/item/weapon/hand_labeler/admin_delabeler/afterattack(atom/A, mob/user as mob, proximity)

	if(!check_rights(R_DEBUG|R_SERVER))	return

	if(findtext(A.name, "(")) //Check if the item is already labeled
		var badlabel = copytext(A.name, findtext(A.name, "("), 0) // If so, memorize its label
		var i = 0

		for(var/obj/Obj in world)
			if(Obj.name && findtext(Obj.name, badlabel)) // If the bad label can be found
				Obj.name = copytext(Obj.name, 1, findtext(Obj.name, "(")-1) // Remove the label from the object
				i++

		for(var/turf/T in world)
			if(T.name && findtext(T.name, badlabel)) // If the bad label can be found
				T.name = copytext(T.name, 1, findtext(T.name, "(")-1) // Remove the label from the turf
				i++

		log_admin("[key_name(user)] used the bluespace delabeler against the following: [badlabel] ([i] objects delabeled)")
		message_admins("<span class='notice'>[key_name(user)] used the bluespace delabeler against the following: [badlabel] ([i] objects delabeled)</span>")
		return

/obj/item/weapon/hand_labeler/admin_delabeler/attack_self(mob/user as mob)
	if(!check_rights(R_DEBUG|R_SERVER))	
		to_chat(user, "You are not supposed to have this and it is useless to you. Ask an admin to delete it.")
		return
	to_chat(user, "<span class='notice'>This object does not set labels - it is always on. It will memorize the label of the target and strip all similar labels from the world.</span>")
