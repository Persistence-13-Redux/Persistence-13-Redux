/obj/machinery/oxygen_pump
	frame_type = /obj/item/frame/oxypump

/obj/machinery/oxygen_pump/empty/New()
	. = ..()
	tank = null

/obj/machinery/oxygen_pump/New()
	..()
	ADD_SAVED_VAR(tank)

/obj/machinery/oxygen_pump/update_icon()
	pixel_x = (dir & 3)? 0 : (dir == 4 ? -30 : 30)
	pixel_y = (dir & 3)? (dir ==1 ? -30 : 30) : 0
	..()
	if(stat & MAINT)
		icon_state = icon_state_open
	else
		icon_state = icon_state_closed

/obj/machinery/oxygen_pump/physical_attack_hand(mob/user)
	if (!tank)
		to_chat(user, "<span class='warning'>There is no tank in \the [src]!</span>")
	. = ..()