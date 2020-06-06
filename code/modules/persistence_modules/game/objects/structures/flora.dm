/obj/structure/flora
	var/can_cut = TRUE
	var/cut_time = 2 SECONDS

/obj/structure/flora/attackby(obj/item/O as obj, mob/user as mob)
	if(can_cut && isHatchet(O))
		to_chat(user, "You start chopping down \the [src]..")
		if(do_after(user, cut_time, src))
			to_chat(user, "You cut \the [src] to pieces.")
			dismantle()
		return 1
	return ..()

/obj/structure/flora/tree
	mass = 20
/obj/structure/flora/grass
	mass = 2
/obj/structure/flora/bush
	mass = 5
	parts = /obj/item/weapon/material/stick //drop a stick
/obj/structure/flora/ausbushes
	mass = 2
	parts = /obj/item/weapon/material/stick //drop a stick
/obj/structure/flora/pottedplant
	mass = 8
	can_cut = FALSE