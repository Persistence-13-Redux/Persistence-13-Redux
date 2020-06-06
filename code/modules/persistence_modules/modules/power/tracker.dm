/obj/machinery/power/tracker/set_control(var/obj/machinery/power/solar_control/SC)
	if(!SC)
		return 0
	control = SC
	return 1
/obj/machinery/power/tracker/set_angle(var/angle)
	if(!control)
		return
	sun_angle = angle

/obj/machinery/power/tracker/attackby(var/obj/item/weapon/crowbar/W, var/mob/user)
	if(isCrowbar(W))
		playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
		user.visible_message("<span class='notice'>[user] begins to take the glass off the solar tracker.</span>")
		if(do_after(user, 50,src))
			var/obj/item/solar_assembly/S = locate() in src
			if(S)
				S.dropInto(loc)
				S.give_glass()
			playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)
			user.visible_message("<span class='notice'>[user] takes the glass off the tracker.</span>")
			dismantle()
		return 1
	return ..()

/obj/machinery/power/tracker/dismantle()
	var/obj/item/solar_assembly/S = locate() in src
	if(S)
		S.dropInto(loc)
		S.give_glass()
	. = ..()
