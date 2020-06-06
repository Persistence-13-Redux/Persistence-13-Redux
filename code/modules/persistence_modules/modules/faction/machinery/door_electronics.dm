/obj/item/weapon/airlock_electronics/attackby(var/obj/item/W, var/mob/user)
	var/obj/item/weapon/card/id/I = W
	if(istype(I, /obj/item/weapon/card/id) && (!req_access_faction || req_access_faction == ""))
		var/datum/world_faction/F = FindFaction(I.get_faction_uid())
		if(!F)
			to_chat(usr, SPAN_WARNING("[\src] flashes a red LED near the ID scanner, indicating your access has been denied."))
			return TRUE
		req_access_faction = F.uid
		if (check_access(I))
			locked = 0
			last_configurator = I.registered_name
		else
			req_access_faction = ""
			to_chat(usr, SPAN_WARNING("[\src] flashes a red LED near the ID scanner, indicating your access has been denied."))
			return TRUE
	return ..()

/obj/item/weapon/airlock_electronics/keypad_electronics
 	name = "keypad airlock electronics"
 	icon_state = "door_electronics_keypad"
 	desc = "An upgraded version airlock electronics board, with a keypad to lock the door."

/obj/item/weapon/airlock_electronics/personal_electronics
 	name = "personal airlock electronics"
 	desc = "An alternative to airlock electronics that locks access to specific personnel"
 										// 1 in list controls door bolting
 	var/list/registered_names = list()	// all others can open the door as normal

/obj/item/weapon/airlock_electronics/personal_electronics/attackby(var/obj/item/I, var/mob/user)
	if(istype(I, /obj/item/weapon/card/id))
		var/obj/item/weapon/card/id/ID = I

		if(ID.registered_name in registered_names)
			return

		if(!registered_names.len)
			to_chat(user, "You set [ID.registered_name] as \the [src]' owner.")
		else
			to_chat(user, "You add [ID.registered_name] to \the [src]' allowed access list.")

		registered_names += ID.registered_name

 	if(isMultitool(I))
 		registered_names.Cut()

 		to_chat(user, "You pulse \the [src], resetting the allowed access list.")
