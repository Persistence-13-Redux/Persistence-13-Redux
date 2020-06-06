/obj/machinery/beehive/New()
	. = ..()
	ADD_SAVED_VAR(closed)
	ADD_SAVED_VAR(bee_count)
	ADD_SAVED_VAR(smoked)
	ADD_SAVED_VAR(honeycombs)
	ADD_SAVED_VAR(frames)


/obj/machinery/beehive/dismantle()
	new /obj/item/beehive_assembly(get_turf(src))
	qdel(src)


/obj/machinery/honey_extractor/New()
	. = ..()
	ADD_SAVED_VAR(processing)
	ADD_SAVED_VAR(honey)

/obj/machinery/honey_extractor/on_update_icon()
	. = ..()
	if(processing)
		icon_state = "[initial(icon_state)]_moving"
	else
		icon_state = initial(icon_state)

/obj/item/honey_frame/New()
	. = ..()
	ADD_SAVED_VAR(honey)

/obj/item/honey_frame/Initialize()
	. = ..()
	queue_icon_update()

/obj/item/honey_frame/on_update_icon()
	. = ..()
	overlays.Cut()
	if(honey > 0)
		overlays += "honeycomb"

//We use the material system for wax..
/obj/item/stack/wax
	name = "ERROR"
	singular_name = ""
	desc = "ERROR"
	icon = 'icons/obj/beekeeping.dmi'
	icon_state = "wax"
/obj/item/stack/wax/New() return
/obj/item/stack/wax/Initialize()
	return INITIALIZE_HINT_QDEL
	

/obj/item/bee_pack/New()
	..()
	ADD_SAVED_VAR(full)

/obj/item/bee_pack/Initialize()
	. = ..()
	queue_icon_update()
	
/obj/item/bee_pack/on_update_icon()
	. = ..()
	overlays.Cut()
	if(full)
		overlays += "beepack-full"
		SetName(initial(name))
		desc = initial(desc)
	else
		overlays += "beepack-empty"
		name = "empty bee pack"
		desc = "A stasis pack for moving bees. It's empty."

/obj/item/bee_pack/empty()
	full = 0
	update_icon()

/obj/item/bee_pack/fill()
	full = initial(full)
	update_icon()

