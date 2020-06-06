/obj/item/device/flashlight
	var/power_usage = 2
	var/obj/item/weapon/cell/flashlight_cell = null

/obj/item/device/flashlight/get_cell()
	return flashlight_cell

/obj/item/device/flashlight/attack_self(mob/user)
	if(power_usage)
		if(!get_cell() || (get_cell() && !(get_cell().check_charge(power_usage * CELLRATE))))
			to_chat(user, "<span class='warning'>\The [src] refuses to operate.</span> ")
			return FALSE
	. = ..()

/obj/item/device/flashlight/set_flashlight()
	if (on)
		set_light(flashlight_max_bright, flashlight_inner_range, flashlight_outer_range, 2, light_color)
		START_PROCESSING(SSobj, src)
	else
		set_light(0)
		STOP_PROCESSING(SSobj, src)
	update_icon()
	if(usr)
		usr.update_action_buttons()

/obj/item/device/flashlight/pen
	matter = list(MATERIAL_STEEL = 30,MATERIAL_GLASS = 10)

/obj/item/device/flashlight/drone
	power_usage = 0

/obj/item/device/flashlight/flare
	power_usage = 0 //Don't use batteries!!!!

/obj/item/device/flashlight/flare/New()
	. = ..()
	ADD_SAVED_VAR(fuel)

/obj/item/device/flashlight/slime
	power_usage = 0


/obj/item/device/flashlight/New()
	..()
	ADD_SAVED_VAR(on)
	ADD_SAVED_VAR(flashlight_cell)
	ADD_SKIP_EMPTY(flashlight_cell)

/obj/item/device/flashlight/examine(mob/user)
	if(..(user, 0))
		if (!power_usage)
			return
		if(flashlight_cell)
			to_chat(user,"<span class='notice'>There is about [round(src.flashlight_cell.percent(), 1)]% charge remaining.</span>")
		else
			to_chat(user,"<span class='warning'>\The [src] is missing a battery!</span>")

/obj/item/device/flashlight/Process(mob/user)
	if(!get_cell())
		on = FALSE
		set_flashlight()
		return
	if(!get_cell().checked_use(power_usage * CELLRATE))	//if this passes, there's not enough power in the battery
		on = FALSE
		set_flashlight()
		to_chat(user,"<span class='warning'>\The [src] flickers briefly as the last of its charge is depleted.</span>")
		return

/obj/item/device/flashlight/attackby(var/obj/item/I, var/mob/user as mob)
	if(isScrewdriver(I))
		if(power_usage && get_cell())	//if contains powercell & uses power
			flashlight_cell.update_icon()
			flashlight_cell.dropInto(loc)
			flashlight_cell = null
			to_chat(user, "<span class='notice'>You remove \the [flashlight_cell] from \the [src].</span>")
		else if (power_usage && !get_cell())	//does not contains cell, but still uses power
			to_chat(user, "<span class='notice'>There's no battery in \the [src].</span>")
		else	//no chat message for lights that don't use power
			return
	if(power_usage && !get_cell() && istype(I, /obj/item/weapon/cell/device) && user.unEquip(I, target = src))
		if (get_cell())
			to_chat(user, "<span class='notice'>\The [src] already has a battery installed.</span>")
		if(power_usage && !get_cell() && user.unEquip(I))
			I.forceMove(src)
			flashlight_cell = I
			to_chat(user, "<span class='notice'>You install [I] into \the [src].</span>")
			update_icon()
		else	//no message for trying to put batteries in glowsticks
			return

/obj/item/device/flashlight/emp_act(severity)
	if(flashlight_cell)	//only flashlights with cells installed are affected
		on = FALSE
		set_flashlight()
		flashlight_cell.emp_act(severity)
	..()

