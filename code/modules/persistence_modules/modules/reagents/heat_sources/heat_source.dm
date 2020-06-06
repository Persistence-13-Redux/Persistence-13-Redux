// /obj/machinery/reagent_temperature
// 	max_temperature =      300 CELSIUS
// 	min_temperature =      20  CELSIUS
// 	heating_power =        100 // K
// 	min_temperature = -100 CELSIUS

/obj/machinery/reagent_temperature/New()
	. = ..()
	ADD_SAVED_VAR(container)
	ADD_SAVED_VAR(target_temperature)

/obj/machinery/reagent_temperature/Initialize()
	. = ..()
	RefreshParts()

/obj/machinery/reagent_temperature/set_anchored(new_anchored)
	if(!new_anchored && !isoff())
		update_use_power(POWER_USE_OFF)
	. = ..()

/obj/machinery/reagent_temperature/attackby(var/obj/item/thing, var/mob/user)
	if(thing.is_open_container() && container && container.is_open_container())
		var/obj/item/weapon/reagent_containers/C = thing
		if(C)
			C.standard_pour_into(user, container)
		return 1
	return ..()
