/obj/effect/decal/cleanable/ash/SetupReagents()
	. = ..()
	create_reagents(10)
	reagents.add_reagent(/datum/reagent/carbon, 10)

//Scoop the ashes up in a beaker to get some carbon
/obj/effect/decal/cleanable/ash/attackby(obj/item/I, mob/user)
	if(I.is_open_container() && I.reagents && I.reagents.get_free_space() > 0 && reagents.total_volume > 0)
		reagents.trans_to(I, 10)
		user.visible_message(SPAN_NOTICE("[user] carefully scoops up the ashes into \the [I]."), SPAN_NOTICE("You scoop up as much of \the [src] as possible into \the [I]."))
		qdel(src)
		return FALSE
	return ..()

/obj/effect/decal/cleanable/vomit/on_update_icon()
	if(!reagents)
		return
	. = ..()