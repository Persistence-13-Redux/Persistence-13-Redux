//LEGACY ASSEMBLY CODE!!
/obj/machinery/atm
	var/buildstage = 2	// 2 = complete, 1 = no wires,  0 = circuit gone
	var/wiresexposed = 0
	frame_type = /obj/item/frame/atm

/obj/machinery/atm/New(loc, dir, atom/frame, var/ndir)	//ATM is created from frame
	if(istype(frame))
		buildstage = 0
		wiresexposed = 1
		frame.transfer_fingerprints_to(src)
	..()
	if(ndir)
		set_dir(ndir)
		update_icon()

/obj/machinery/atm/Initialize(mapload, d)
	. = ..()
	queue_icon_update()

/obj/machinery/atm/update_icon()	//Sprites for each build stage
	overlays.Cut()
	//ATMs can only exist on walls. So its better to just do it like this.
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = -32
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = 40
		if(EAST)
			src.pixel_x = -36
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = 36
			src.pixel_y = 0

	if(wiresexposed)
		switch(buildstage)
			if(2)
				icon_state="atm_off"
			if(1)
				icon_state="atm_off"
			if(0)
				icon_state="atm_off"
		set_light(0)
		return
	else
		icon_state = "atm"

/obj/machinery/atm/attackby(obj/item/W as obj, mob/user as mob)	//Build code
	src.add_fingerprint(user)

	if(isScrewdriver(W) && buildstage == 2)
		wiresexposed = !wiresexposed
		update_icon()
		return 1

	if(wiresexposed)
		switch(buildstage)
			if(2)
				if(isWirecutter(W))
					user.visible_message("<span class='notice'>\The [user] has cut the wires inside \the [src]!</span>", "<span class='notice'>You have cut the wires inside \the [src].</span>")
					new/obj/item/stack/cable_coil(get_turf(src), 5)
					playsound(src.loc, 'sound/items/Wirecutter.ogg', 50, 1)
					buildstage = 1
					update_icon()
			if(1)
				if(istype(W, /obj/item/stack/cable_coil))
					var/obj/item/stack/cable_coil/C = W
					if (C.use(5))
						to_chat(user, "<span class='notice'>You wire \the [src].</span>")
						buildstage = 2
						return
					else
						to_chat(user, "<span class='warning'>You need 5 pieces of cable to wire \the [src].</span>")
						return
				else if(isCrowbar(W))
					to_chat(user, "You pry out the circuit!")
					playsound(src.loc, 'sound/items/Crowbar.ogg', 50, 1)
					spawn(20)
						if(buildstage == 1) //Prevents circuit duplication
							var/obj/item/weapon/stock_parts/circuitboard/atm/circuit = new /obj/item/weapon/stock_parts/circuitboard/atm()
							circuit.dropInto(user.loc)
							buildstage = 0
							update_icon()
			if(0)
				if(istype(W, /obj/item/weapon/stock_parts/circuitboard/atm))
					to_chat(user, "You insert the circuit!")
					qdel(W)
					buildstage = 1
					update_icon()

				else if(isWrench(W))
					to_chat(user, "You remove the ATM assembly from the wall!")
					new /obj/item/frame/atm(get_turf(user))
					playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
					qdel(src)
		return 1

	return

/obj/item/frame/atm/try_build(turf/on_wall)
	if (get_dist(on_wall,usr)>1)
		return
	var/ndir = get_dir(usr,on_wall)
	if (!(ndir in GLOB.cardinal))
		return
	var/turf/loc = get_turf(usr)

	new /obj/machinery/atm(loc, 1, src, ndir)
	qdel(src)