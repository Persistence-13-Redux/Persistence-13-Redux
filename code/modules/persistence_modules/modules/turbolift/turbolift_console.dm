/obj/structure/lift
	req_access = list()
	req_access_faction = ""
	req_access_personal = list()

/obj/structure/lift/button/interact(var/mob/user)
	if(!src.allowed(user))
		playsound(src.loc, 'sound/machines/buzz-two.ogg', 50, 0)
		to_chat(user, SPAN_WARNING("Access denied!"))
		return
	. = ..()

/obj/structure/lift/panel/interact(var/mob/user)
	if(!src.allowed(user))
		playsound(src.loc, 'sound/machines/buzz-two.ogg', 50, 0)
		to_chat(user, SPAN_WARNING("Access denied!"))
		return
	. = ..()