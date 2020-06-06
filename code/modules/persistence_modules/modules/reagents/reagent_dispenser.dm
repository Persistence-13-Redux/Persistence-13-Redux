/obj/structure/reagent_dispensers
	var/can_fill = FALSE //Whether the tank's cap is opened for pouring reagents in

/obj/structure/reagent_dispensers/New()
	..()
	ADD_SAVED_VAR(amount_per_transfer_from_this)

// /obj/structure/reagent_dispensers/destroyed(damagetype, user)
// 	if(reagents)
// 		reagents.splash(loc, reagents.total_volume, 1, 0, 80, 100)
// 		new /obj/effect/effect/water(src.loc)
// 	. = ..()

/obj/structure/reagent_dispensers/attackby(var/obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W,/obj/item/weapon/reagent_containers))
		return //Don't hit the dispenser idiot!
	else 
		return ..()

/obj/structure/reagent_dispensers/attack_hand(mob/user)
	if(user.a_intent == I_HELP)
		can_fill = !can_fill

		if(can_fill)
			visible_message(SPAN_NOTICE("[user] pop off the cap."))
			atom_flags |= ATOM_FLAG_OPEN_CONTAINER
		else
			visible_message(SPAN_NOTICE("[user] tighten the cap."))
			atom_flags &= ~ATOM_FLAG_OPEN_CONTAINER
			
		src.add_fingerprint(user)
		return 1
	else
		return ..()

/obj/structure/reagent_dispensers/default_deconstruction_screwdriver(var/obj/item/weapon/screwdriver/S, var/mob/living/user, var/deconstruct_time = null)
	if(!istype(S))
		return 0
	if(reagents.total_volume > 1)
		to_chat(user, SPAN_WARNING("Empty it first!"))
	else
		return ..()

/obj/structure/reagent_dispensers/default_deconstruction_wrench(var/obj/item/weapon/wrench/W, var/mob/living/user, var/deconstruct_time = null)
	if(!istype(W))
		return 0
	if(reagents.total_volume != 0)
		to_chat(user, SPAN_WARNING("Empty it first!"))
	else
		return ..()
	
//Definitions
/obj/structure/reagent_dispensers/watertank/empty
	initial_reagent_types = null

/obj/structure/reagent_dispensers/fueltank/empty
	initial_reagent_types = null

/obj/structure/reagent_dispensers/water_cooler/empty
	initial_reagent_types = null

/obj/structure/reagent_dispensers/beerkeg/empty
	initial_reagent_types = null

/obj/structure/reagent_dispensers/acid/empty
	initial_reagent_types = null


/obj/structure/reagent_dispensers/beerkeg/default_deconstruction_screwdriver(obj/item/weapon/screwdriver/S, mob/living/user, deconstruct_time)
	if(reagents.total_volume == 0)
		. = ..()
	else
		to_chat(user, "<span class='notice'>Empty it first!</span>")
/obj/structure/reagent_dispensers/beerkeg/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(default_deconstruction_screwdriver(W, user, 2 SECONDS))
		return
	return ..()


//
//	Wall-mounted reagent dispensers base class
//
/obj/structure/reagent_dispensers/wall
	density = FALSE
	anchored = TRUE

/obj/structure/reagent_dispensers/wall/Initialize()
	. = ..()
	update_icon()

/obj/structure/reagent_dispensers/wall/on_update_icon()
	. = ..()
	switch(dir)
		if(NORTH)
			src.pixel_x = 0
			src.pixel_y = 30
		if(SOUTH)
			src.pixel_x = 0
			src.pixel_y = -30
		if(EAST)
			src.pixel_x = 30
			src.pixel_y = 0
		if(WEST)
			src.pixel_x = -30
			src.pixel_y = 0

/obj/structure/reagent_dispensers/wall/attackby(var/obj/item/weapon/W as obj, mob/user as mob)
	if(default_deconstruction_wrench(user,W))
		return TRUE
	else
		return ..()

/obj/structure/reagent_dispensers/wall/virusfood
	name = "virus food dispenser"
	desc = "A dispenser of virus food."
	icon = 'icons/obj/objects.dmi'
	icon_state = "virusfoodtank"
	amount_per_transfer_from_this = 10

	initial_reagent_types = list(/datum/reagent/nutriment/virus_food = 1)

/obj/structure/reagent_dispensers/wall/virusfood/empty
	initial_reagent_types = null

/obj/structure/reagent_dispensers/wall/virusfood/dismantle()
	new /obj/item/frame/plastic/virusfoodtank(loc)
	qdel(src)

/obj/structure/reagent_dispensers/wall/acid/empty
	initial_reagent_types = null

/obj/structure/reagent_dispensers/wall/acid/dismantle()
	new /obj/item/frame/plastic/acidtank(loc)
	qdel(src)

/obj/structure/reagent_dispensers/wall/peppertank/empty
	initial_reagent_types = null

/obj/structure/reagent_dispensers/wall/peppertank/dismantle()
	new /obj/item/frame/plastic/peppertank(loc)
	qdel(src)