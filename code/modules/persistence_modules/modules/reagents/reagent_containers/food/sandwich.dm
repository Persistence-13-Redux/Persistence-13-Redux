/obj/item/weapon/reagent_containers/food/snacks/csandwich/New()
	. = ..()
	ADD_SAVED_VAR(ingredients)
	ADD_SKIP_EMPTY(ingredients)

/obj/item/weapon/reagent_containers/food/snacks/csandwich/Initialize()
	. = ..()
	update()
