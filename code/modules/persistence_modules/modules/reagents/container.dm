// /obj/item/weapon/reagent_containers
// 	var/list/datum/reagent/starts_with = null

/obj/item/weapon/reagent_containers/New()
	..()
	ADD_SAVED_VAR(amount_per_transfer_from_this)
	ADD_SAVED_VAR(atom_flags) //Since we change the open_container flag a lot

/obj/item/weapon/reagent_containers/SetupReagents()
	..()
	create_reagents(volume)
	// if(starts_with)
	// 	for(var/T in starts_with)
	// 		reagents.add_reagent(T, starts_with[T])
	// 	queue_icon_update()

/obj/item/weapon/reagent_containers/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/pen) || istype(W, /obj/item/device/flashlight/pen))
		var/datum/extension/labels/L = get_extension(src, /datum/extension/labels)
		var/old_label = LAZYLEN(L.labels) ? L.labels[1] : ""
		var/tmp_label = sanitizeSafe(input(user, "Enter a label for [name]", "Label", old_label), MAX_NAME_LEN)
		set_label(user, tmp_label)
		return 1 //Keeps afterattack from triggering
	else
		return ..()

//Don't need this anymore. The label extension does it
// /obj/item/weapon/reagent_containers/proc/update_name_label()
// 	if(label == "")
// 		SetName(initial(name))
// 	else
// 		SetName("[initial(name)] ([label])")

/obj/item/weapon/reagent_containers/standard_dispenser_refill(var/mob/user, var/obj/structure/reagent_dispensers/target) // This goes into afterattack
	if(!istype(target))
		return 0
	
	if(target.can_fill)
		return 0 //Run regular reagent container code if the dispenser is open!
	
	. = ..()


/obj/item/weapon/reagent_containers/proc/get_first_label()
	. = ""
	var/datum/extension/labels/L = get_extension(src, /datum/extension/labels)
	if(L && LAZYLEN(L.labels))
		. = L.labels[1]
	return .

/obj/item/weapon/reagent_containers/proc/set_label(var/mob/user, var/tmp_label)
	var/datum/extension/labels/L = get_or_create_extension(src, /datum/extension/labels, /datum/extension/labels)
	//var/old_label = LAZYLEN(L.labels) ? L.labels[1] : ""
	if(length(tmp_label) > 25)
		if(user) to_chat(user, SPAN_WARNING("The label can be at most 25 characters long."));
	else
		L.RemoveAllLabels() 

		if(length(tmp_label) == 0)
			if(user) to_chat(user, SPAN_NOTICE("You remove the label."));
		else
			//if(user) to_chat(user, SPAN_NOTICE("You set the label to \"[tmp_label]\"."));
			L.AttachLabel(user, tmp_label)
