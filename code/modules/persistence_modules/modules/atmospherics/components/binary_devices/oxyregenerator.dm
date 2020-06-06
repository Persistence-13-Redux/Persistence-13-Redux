/obj/machinery/atmospherics/binary/oxyregenerator/New()
	inner_tank.volume = tank_volume
	ADD_SAVED_VAR(target_pressure)
	ADD_SAVED_VAR(id)
	ADD_SAVED_VAR(power_setting)
	ADD_SAVED_VAR(carbon_stored)
	ADD_SAVED_VAR(phase)
	ADD_SAVED_VAR(inner_tank)

/obj/machinery/atmospherics/binary/oxyregenerator/RefreshParts()
	for(var/obj/item/weapon/stock_parts/P in component_parts)
		if(istype(P, /obj/item/weapon/stock_parts/matter_bin))
			carbon_efficiency += 0.25 * (P.rating-1) //plus 25% per stock item rank
		if(istype(P, /obj/item/weapon/stock_parts/manipulator))
			intake_power_efficiency -= 0.1 * (P.rating-1) //10% better intake power efficiency per stock item rank
		if(istype(P, /obj/item/weapon/stock_parts/micro_laser))
			power_rating -= power_rating * 0.05 * (P.rating-1) //5% better power efficiency per stock item rank
	..()
