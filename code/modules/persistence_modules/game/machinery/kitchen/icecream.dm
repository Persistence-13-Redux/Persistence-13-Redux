/obj/machinery/icecream_vat/New()
	. = ..()
	ADD_SAVED_VAR(dispense_flavour)

/obj/machinery/icecream_vat/Initialize()
	var/datum/reagents/oldreg = reagents
	. = ..()
	if(map_storage_loaded)
		reagents = oldreg //To avoid the base class replacing saved values we set it back here

/obj/item/weapon/reagent_containers/food/snacks/icecream/New()
	..()
	ADD_SAVED_VAR(ice_creamed)
	ADD_SAVED_VAR(cone_type)
	ADD_SKIP_EMPTY(cone_type)

/obj/item/weapon/reagent_containers/food/snacks/icecream/Initialize()
	var/datum/reagents/oldreg = reagents
	. = ..()
	if(map_storage_loaded)
		reagents = oldreg //To avoid the base class replacing saved values we set it back here
