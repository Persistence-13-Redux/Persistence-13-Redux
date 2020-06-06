/obj/item/device/radio/intercom
	var/buildstage = 0
	var/wiresexposed = FALSE
	var/circuitry_installed = TRUE


/obj/item/device/radio/intercom/attackby(obj/item/weapon/W as obj, mob/user as mob, params)
	if(istype(W, /obj/item/device/scanner/reagent))
		return
	if(istype(W, /obj/item/weapon/wrench))
		to_chat(user, "<span class='notice'>You detach \the [src] from the wall.</span>")
		new /obj/item/frame/intercom(get_turf(src))
		qdel(src)
		return 1
	return src.attack_hand(user)

/obj/item/device/radio/intercom/New(loc, dir, atom/frame)
	..(loc)
	if(dir)
		src.set_dir(dir)
	if(istype(frame))
		buildstage = 0
		wiresexposed = TRUE
		frame.transfer_fingerprints_to(src)

/obj/item/device/radio/intercom/Initialize()
	. = ..()
	update_icon()

/obj/item/device/radio/intercom/update_icon()
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = -28
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = 24
		if(EAST)
			src.pixel_x = -22
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = 22
			src.pixel_y = 0
	if(!circuitry_installed)
		icon_state="intercom-frame"
		return
	icon_state = "intercom[!on?"-p":""][b_stat ? "-open":""]"

/obj/item/weapon/intercom_electronics
	name = "intercom electronics"
	icon = 'icons/obj/doors/door_assembly.dmi'
	icon_state = "door_electronics"
	desc = "Looks like a circuit. Probably is."
	w_class = ITEM_SIZE_SMALL
	matter = list(MATERIAL_STEEL = 50, MATERIAL_GLASS = 50)
	origin_tech = "engineering=2;programming=1"


/obj/item/device/radio/intercom/attackby(obj/item/W as obj, mob/user as mob)
	src.add_fingerprint(user)

	switch(buildstage)
		if(2)
			if(isScrewdriver(W))  // Opening that Intercom up.
				to_chat(user, "You pop the [src] maintence panel open.")
				wiresexposed = !wiresexposed
				to_chat(user, "The wires have been [wiresexposed ? "exposed" : "unexposed"]")
				update_icon()
				return

			if (wiresexposed && isWirecutter(W))
				user.visible_message("<span class='warning'>[user] has cut the wires inside \the [src]!</span>", "You have cut the wires inside \the [src].")
				playsound(src.loc, 'sound/items/Wirecutter.ogg', 50, 1)
				new/obj/item/stack/cable_coil(get_turf(src), 5)
				buildstage = 1
				update_icon()
				return


		if(1)
			if(isCoil(W))
				var/obj/item/stack/cable_coil/C = W
				if (C.use(5))
					to_chat(user, "<span class='notice'>You wire \the [src].</span>")
					buildstage = 2
					update_icon()
					return
				else
					to_chat(user, "<span class='warning'>You need 5 pieces of cable to do wire \the [src].</span>")
					return

			else if(isCrowbar(W))
				to_chat(user, "You start prying out the [src] circuit.")
				playsound(src.loc, 'sound/items/Crowbar.ogg', 50, 1)
				if(do_after(user,20))
					to_chat(user, "You pry out the [src] circuit!")
					var/obj/item/weapon/intercom_electronics/circuit = new /obj/item/weapon/intercom_electronics()
					circuit.dropInto(user.loc)
					buildstage = 0
					update_icon()
				return
		if(0)
			if(istype(W, /obj/item/weapon/intercom_electronics))
				to_chat(user, "You insert the [src] circuit!")
				qdel(W)
				buildstage = 1
				update_icon()
				return

			else if(isWrench(W))
				to_chat(user, "You remove the [src] assembly from the wall!")
				new /obj/item/frame/intercom(get_turf(user))
				playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
				qdel(src)

	return ..()
