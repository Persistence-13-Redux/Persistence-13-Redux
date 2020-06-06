/obj/structure/ore_box/New()
	. = ..()
	ADD_SAVED_VAR(stored_ore)

/obj/structure/ore_box/after_load()
	..()
	update_ore_count()

// /obj/structure/ore_box/destroyed(damtype, user)
// 	for (var/obj/item/stack/ore/O in contents)
// 		contents -= O
// 		O.loc = src.loc
// 	if(istype(user, /mob/living/simple_animal/hostile))
// 		var/mob/living/simple_animal/hostile/attacker = user
// 		attacker.target_mob = null
// 	..()

/obj/structure/ore_box/dismantle()
	new /obj/item/stack/material/wood(src)
	for (var/obj/item/O in contents)
		O.dropInto(src)
		contents -= O
	. = ..()

/obj/structure/ore_box/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if (istype(W, /obj/item/stack/ore) || istype(W, /obj/item/stack/material_dust))
		var/obj/item/stack/orestack = W
		user.remove_from_mob(orestack)
		orestack.drop_to_stacks(src)
		update_ore_count()
		return 1
	if(isCrowbar(W))
		user.visible_message(SPAN_NOTICE("[user] tears down \the [src]."),
							 SPAN_NOTICE("You take apart \the [src]."),
							 SPAN_NOTICE("You hear splitting wood."))
		dismantle()
		return 1
	return ..()

//Handle stackable ore
/obj/structure/ore_box/update_ore_count()
	stored_ore = list()
	for(var/obj/item/stack/ore/O in contents)
		if(!stored_ore[O.name])
			stored_ore[O.name] = 0
		stored_ore[O.name] += O.amount

//Override so i
/obj/structure/ore_box/ex_act(severity)
	if(severity == 1.0 || (severity < 3.0 && prob(50)))
		for (var/obj/item/I in contents)
			I.dropInto(loc)
			I.ex_act(severity++)
	..()

/obj/structure/ore_box/empty_box()
	if(!istype(usr, /mob/living/carbon/human)) //Only living, intelligent creatures with hands can empty ore boxes.
		to_chat(usr, SPAN_WARNING("You are physically incapable of emptying the ore box."))
		return

	if( usr.stat || usr.restrained() )
		return

	if(!Adjacent(usr)) //You can only empty the box if you can physically reach it
		to_chat(usr, SPAN_WARNING("You cannot reach the ore box."))
		return

	add_fingerprint(usr)

	if(contents.len < 1)
		to_chat(usr, SPAN_WARNING("The ore box is empty"))
		return

	for (var/obj/item/O in contents)
		contents -= O
		O.dropInto(loc)
	to_chat(usr, SPAN_NOTICE("You empty the ore box"))