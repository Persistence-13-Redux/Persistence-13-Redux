/obj/item/weapon/reagent_containers/food/snacks/New()
	. = ..()
	ADD_SAVED_VAR(bitesize)
	ADD_SAVED_VAR(bitecount)
	ADD_SAVED_VAR(slice_path)
	ADD_SAVED_VAR(slices_num)
	ADD_SAVED_VAR(dried_type)
	ADD_SAVED_VAR(dry)
	ADD_SAVED_VAR(nutriment_amt)
	ADD_SAVED_VAR(nutriment_desc)
	ADD_SAVED_VAR(icon_state)

/obj/item/weapon/reagent_containers/food/snacks/slice/New()
	. = ..()
	ADD_SAVED_VAR(whole_path)
	ADD_SAVED_VAR(filled)

/obj/item/pizzabox/Initialize()
	//Don't let the base class overwrite those vars
	var/old_pizza = pizza
	var/old_tag = boxtag
	. = ..()
	if(map_storage_loaded)
		pizza = old_pizza
		boxtag = old_tag

/obj/item/weapon/reagent_containers/food/snacks/donut/New()
	. = ..()
	ADD_SAVED_VAR(overlay_state)
	ADD_SAVED_VAR(name)
	ADD_SAVED_VAR(icon_state)
	ADD_SAVED_VAR(filling_color)


