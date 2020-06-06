/obj/machinery/button
	icon = 'icons/obj/objects.dmi'
	//Icons states
	var/icon_active 	= "launcheract"
	var/icon_idle 		= "launcherbtt"
	var/icon_unpowered 	= "launcherbtt"
	var/icon_anim_act   = null
	var/icon_anim_deny  = null
	var/sound_toggle 	= "button"

/obj/machinery/button/interface_interact(user)
	if(!CanInteract(user, DefaultTopicState()))
		return FALSE
	else
		to_chat(user, SPAN_WARNING("Access Denied"))
		if(icon_anim_deny)
			flick(icon_anim_deny, src)
			sleep(10)
		return FALSE
	if(istype(user, /mob/living/carbon))
		playsound(src, sound_toggle, 60)
	activate(user)
	return TRUE

/obj/machinery/button/activate(mob/living/user)
	. = ..()
	if(operating && icon_anim_act)
		flick(icon_anim_act, src)

/obj/machinery/button/update_icon()
	if(!ispowered() && icon_unpowered)
		icon_state = icon_unpowered
	else 
		if(active)
			icon_state = icon_active
		else
			icon_state = icon_idle
		
	//Some switches don't want to change their icons when unpowered!
	
	//First check for a wall
	//If there's no wall, just assume we're fine with pixels 0,0
	var/turf/T = get_step(get_turf(src), GLOB.reverse_dir[dir])
	if(istype(T) && T.density)
		switch(dir)
			if(NORTH)
				src.pixel_x = 0
				src.pixel_y = -20
			if(SOUTH)
				src.pixel_x = 0
				src.pixel_y = 26
			if(EAST)
				src.pixel_x = -22
				src.pixel_y = 0
			if(WEST)
				src.pixel_x = 22
				src.pixel_y = 0
	else
		//Since we can be placed on the floor, or tables or whatever
		src.pixel_x = 0
		src.pixel_y = 0
	

/obj/machinery/button/switch
	icon = 'icons/obj/power.dmi'
	icon_state 		= "light0"
	icon_active 	= "light1"
	icon_idle 		= "light0"
	icon_unpowered 	= "light-p"

/obj/machinery/button/alternate
	icon = 'icons/obj/stationobjs.dmi'
	icon_state 		= "doorctrl2"
	icon_active 	= "doorctrl"
	icon_idle 		= "doorctrl2"
	icon_unpowered 	= "doorctrl-p"
	icon_anim_act   = "doorctrl1"
	icon_anim_deny  = "doorctrl-denied"

/obj/machinery/button/toggle/switch
	icon = 'icons/obj/power.dmi'
	icon_state 		= "light0"
	icon_active 	= "light1"
	icon_idle 		= "light0"
	icon_unpowered 	= "light0"

/obj/machinery/button/toggle/alternate
	icon = 'icons/obj/stationobjs.dmi'
	icon_state 		= "doorctrl2"
	icon_active 	= "doorctrl"
	icon_idle 		= "doorctrl2"
	icon_unpowered 	= "doorctrl-p"
	icon_anim_act   = "doorctrl1"
	icon_anim_deny  = "doorctrl-denied"

/obj/machinery/button/toggle/lever
	icon = 'icons/obj/stationobjs.dmi'
	icon_state 		= "switch-up"
	icon_active 	= "switch-down"
	icon_idle 		= "switch-up"
	icon_unpowered 	= null //levers don't have unpowered state

/obj/machinery/button/toggle/lever/dbl
	icon = 'icons/obj/stationobjs.dmi'
	icon_state 		= "switch-dbl-up"
	icon_active 	= "switch-dbl-down"
	icon_idle 		= "switch-dbl-up"

/obj/machinery/button/alternate/door
	icon = 'icons/obj/stationobjs.dmi'
	icon_state 		= "doorctrl2"
	icon_active 	= "doorctrl"
	icon_idle 		= "doorctrl2"
	icon_unpowered 	= "doorctrl-p"
	icon_anim_act   = "doorctrl1"
	icon_anim_deny  = "doorctrl-denied"

/obj/machinery/button/toggle/valve
	icon_active 		= "launcheract"
	icon_idle 			= "launcherbtt"
	icon_unpowered 		= "launcherbtt"