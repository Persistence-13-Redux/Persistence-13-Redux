/obj/item/weapon/flame/lighter/New()
	. = ..()
	ADD_SAVED_VAR(color)

/obj/item/weapon/flame/lighter/Initialize()
	. = ..()
	set_extension(src, /datum/extension/base_icon_state, icon_state)
	if(!map_storage_loaded && random_colour)
		color = pick(available_colors)
	update_icon()

/obj/item/weapon/flame/lighter/SetupReagents()
	. = ..()
	create_reagents(max_fuel)
	reagents.add_reagent(/datum/reagent/fuel, max_fuel)