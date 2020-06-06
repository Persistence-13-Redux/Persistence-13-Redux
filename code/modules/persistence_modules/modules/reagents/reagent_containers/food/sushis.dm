/obj/item/weapon/reagent_containers/food/snacks/sushi/New(newloc, obj/item/weapon/reagent_containers/food/snacks/rice, obj/item/weapon/reagent_containers/food/snacks/topping)
	. = ..()
	ADD_SAVED_VAR(fish_type)

/obj/item/weapon/reagent_containers/food/snacks/sashimi/New(var/newloc, var/_fish_type)
	..()
	ADD_SAVED_VAR(fish_type)
	ADD_SAVED_VAR(slices)