
//Override implementation of programs from code\modules\modular_computers\file_system\program.dm
//Make computer programs return the faction its tied with (Sounds reaaaaally redundant tbh)
/datum/computer_file/program/proc/get_network_faction()
	return computer?.get_network_faction()

/datum/computer_file/program/proc/get_network_faction_uid()
	return src.get_network_faction()?.uid

/datum/computer_file/program/proc/get_network()
	return computer?.get_network()?.uid

/datum/computer_file/program/proc/get_network_uid()
	return src.get_network()?.uid

/datum/computer_file/program/can_run(var/mob/living/user, var/loud = 0, var/access_to_check)
	. = ..()
	if(!.)
		return .
	
	var/datum/world_faction/fac = get_network_faction()
	// if(category == PROG_GOVERNMENT)
	// 	if(!(fac && istype(fac, /datum/world_faction/democratic)))
	// 		if(loud)
	// 			to_chat(user, "<span class='notice'>\The [computer] must be connected to the government network for this program to run.</span>")
	// 		return 0
	// if(category == PROG_BUSINESS)
	// 	if(!(fac && istype(fac, /datum/world_faction/business)))
	// 		if(loud)
	// 			to_chat(user, "<span class='notice'>\The [computer] must be connected to a business network for this program to run.</span>")
	// 		return 0
	if(!access_to_check) // No required_access, allow it.
		return 1
	var/obj/item/weapon/card/id/I = user.GetIdCard()
	if(!I)
		if(loud)
			to_chat(user, "<span class='notice'>\The [computer] flashes an \"RFID Error - Unable to scan ID\" warning.</span>")
		return 0
	if(fac)
		if(access_to_check in I.GetAccess(fac.uid))
			return 1
		else if(loud)
			to_chat(user, "<span class='notice'>\The [computer] flashes an \"Access Denied\" warning.</span>")
	else
		if(access_to_check in I.GetAccess())
			return 1
		else if(loud)
			to_chat(user, "<span class='notice'>\The [computer] flashes an \"Access Denied\" warning.</span>")

