/obj/item/robot_parts/New(var/newloc, var/model)
	..(newloc)
	ADD_SAVED_VAR(part)
	ADD_SAVED_VAR(sabotaged)
	ADD_SAVED_VAR(model_info)
	ADD_SAVED_VAR(bp_tag)

/obj/item/robot_parts/Initialize(mapload, var/model)
	. = ..()
	if(!map_storage_loaded)
		if(model_info && model)
			model_info = model
			var/datum/robolimb/R = all_robolimbs[model]
			if(R)
				SetName("[R.company] [initial(name)]")
				desc = "[R.desc]"
				if(icon_state in icon_states(R.icon))
					icon = R.icon
		else
			SetDefaultName()

// /obj/item/robot_parts/head/attackby(obj/item/W as obj, mob/user as mob)
// 	if(istype(W, /obj/item/weapon/stock_parts/manipulator))
// 		to_chat(user, "<span class='notice'>You install some manipulators and modify the head, creating a functional spider-bot!</span>")
// 		new /mob/living/simple_animal/spiderbot(get_turf(loc))
// 		user.drop_item()
// 		qdel(W)
// 		qdel(src)
// 		return
// 	return ..()

