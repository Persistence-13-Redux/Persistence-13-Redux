/obj/structure/plasticflaps
	atmos_canpass = CANPASS_NEVER
	mass = 5

/obj/structure/plasticflaps/attackby(obj/item/weapon/tool/W, mob/user)
	if((isScrewdriver(W)) && (istype(loc, /turf/simulated) || anchored))
		if(do_mob(user, src, 4 SECONDS))
			anchored = !anchored
			user.visible_message("<span class='notice'>[user] [anchored ? "fastens" : "unfastens"] the [src].</span>", \
								 "<span class='notice'>You have [anchored ? "fastened the [src] to" : "unfastened the [src] from"] the floor.</span>")
			return
	if(isWelder(W))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(0) && do_mob(user, src, 4 SECONDS) && WT.isOn())
			dismantle()
			user.visible_message("<span class='warning'>\The [user] deconstructs \the [src].</span>", "<span class='warning'>You deconstruct \the [src].</span>")
		return
	return ..()

/obj/structure/plasticflaps/become_airtight()
	atmos_canpass = CANPASS_NEVER

/obj/structure/plasticflaps/clear_airtight()
	atmos_canpass = CANPASS_ALWAYS
