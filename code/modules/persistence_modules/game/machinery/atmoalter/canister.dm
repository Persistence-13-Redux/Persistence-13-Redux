/obj/machinery/portable_atmospherics/canister
	start_pressure = 148 * ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/after_load()
	..()
	update_icon()

/obj/machinery/portable_atmospherics/canister/check_change()
	if(!air_contents)
		return 1
	. = ..()

/obj/machinery/portable_atmospherics/canister/healthcheck()
	if(destroyed)
		return 1
	if (src.health <= 10)
		disconnect()
	. = ..()

/obj/machinery/portable_atmospherics/canister/Process()
	if (destroyed)
		return
	..()
	if(valve_open && air_contents.return_pressure() != 0)
		var/datum/gas_mixture/environment
		if(holding && holding.air_contents)
			environment = holding.air_contents
		else
			environment = loc? loc.return_air() : null

		//If in space you don't care
		if(!environment)
			return
		var/env_pressure = environment.return_pressure()
		var/pressure_delta = release_pressure - env_pressure

		if((air_contents.temperature > 0) && (pressure_delta > 0))
			var/transfer_moles = calculate_transfer_moles(air_contents, environment, pressure_delta)
			transfer_moles = min(transfer_moles, (release_flow_rate/air_contents.volume)*air_contents.total_moles) //flow rate limit

			var/returnval = pump_gas_passive(src, air_contents, environment, transfer_moles)
			if(returnval >= 0)
				src.update_icon()
				if(holding)
					holding.queue_icon_update()

	if(!air_contents || air_contents.return_pressure() < 1)
		can_label = 1
	else
		can_label = 0

	air_contents.react() //cooking up air cans - add phoron and oxygen, then heat above PHORON_MINIMUM_BURN_TEMPERATURE


//--------------------------------------------------------
// N2O Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/sleeping_agent
	name = "\improper Canister: \[N2O\]"
	icon_state = "redws"
	canister_color = "redws"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/sleeping_agent/init_air_content()
	..()
	air_contents.adjust_gas(GAS_N2O, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// N2 Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/nitrogen
	name = "\improper Canister: \[N2\]"
	icon_state = "red"
	canister_color = "red"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/nitrogen/init_air_content()
	..()
	air_contents.adjust_gas(GAS_NITROGEN, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// N2O Pre-Chilled Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/nitrogen/prechilled
	name = "\improper Canister: \[N2 (Cooling)\]"

/obj/machinery/portable_atmospherics/canister/nitrogen/prechilled/init_air_content()
	..()
	src.air_contents.temperature = 80
	src.queue_icon_update()

//--------------------------------------------------------
// O2 Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/oxygen
	name = "\improper Canister: \[O2\]"
	icon_state = "blue"
	canister_color = "blue"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/oxygen/init_air_content()
	..()
	air_contents.adjust_gas(GAS_OXYGEN, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// O2 Pre-Chilled Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/oxygen/prechilled
	name = "\improper Canister: \[O2 (Cryo)\]"
	start_pressure = 20 * ONE_ATMOSPHERE

/obj/machinery/portable_atmospherics/canister/oxygen/prechilled/init_air_content()
	..()
	air_contents.temperature = 80
	queue_icon_update()

//--------------------------------------------------------
// H2 Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/hydrogen
	name = "\improper Canister: \[Hydrogen\]"
	icon_state = "purple"
	canister_color = "purple"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/hydrogen/init_air_content()
	..()
	air_contents.adjust_gas(GAS_HYDROGEN, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// Phoron Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/phoron
	name = "\improper Canister \[Phoron\]"
	icon_state = "orange"
	canister_color = "orange"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/phoron/init_air_content()
	..()
	air_contents.adjust_gas(GAS_PHORON, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// CO2 Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/carbon_dioxide
	name = "\improper Canister \[CO2\]"
	icon_state = "black"
	canister_color = "black"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/carbon_dioxide/init_air_content()
	..()
	air_contents.adjust_gas(GAS_CO2, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// Air Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/air
	name = "\improper Canister \[Air\]"
	icon_state = "grey"
	canister_color = "grey"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/air/init_air_content()
	..()
	var/list/air_mix = StandardAirMix()
	air_contents.adjust_multi(GAS_OXYGEN, air_mix[GAS_OXYGEN], GAS_NITROGEN, air_mix[GAS_NITROGEN])
	queue_icon_update()

//--------------------------------------------------------
// Airlock Air Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/air/airlock
	start_pressure = 3 * ONE_ATMOSPHERE


//--------------------------------------------------------
// N2O Roomfiller Canister
//--------------------------------------------------------
//Dirty way to fill room with gas. However it is a bit easier to do than creating some floor/engine/n2o -rastaf0
/obj/machinery/portable_atmospherics/canister/sleeping_agent/roomfiller/init_air_content()
	..()
	air_contents.gas[GAS_N2O] = 9*4000
	spawn(10)
		var/turf/simulated/location = src.loc
		if (istype(src.loc))
			while (!location.air)
				sleep(10)
			location.assume_air(air_contents)
			air_contents = new

//--------------------------------------------------------
// N2 Engine Setup Canister
//--------------------------------------------------------
// Special types used for engine setup admin verb, they contain double amount of that of normal canister.
/obj/machinery/portable_atmospherics/canister/nitrogen/engine_setup/init_air_content()
	..()
	air_contents.adjust_gas(GAS_NITROGEN, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// CO2 Engine Setup Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/carbon_dioxide/engine_setup/init_air_content()
	..()
	air_contents.adjust_gas(GAS_CO2, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// Phoron Engine Setup Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/phoron/engine_setup/init_air_content()
	..()
	air_contents.adjust_gas(GAS_PHORON, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// H2 Engine Setup Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/hydrogen/engine_setup/init_air_content()
	..()
	src.air_contents.adjust_gas(GAS_HYDROGEN, MolesForPressure())
	queue_icon_update()


//--------------------------------------------------------
// Helium Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/helium
	name = "\improper Canister \[He\]"
	icon_state = "black"
	canister_color = "black"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/helium/init_air_content()
	..()
	air_contents.adjust_gas(GAS_HELIUM, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// Methyl Bromide Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/methyl_bromide
	name = "\improper Canister \[CH3Br\]"
	icon_state = "black"
	canister_color = "black"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/methyl_bromide/init_air_content()
	..()
	air_contents.adjust_gas(GAS_METHYL_BROMIDE, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// Chlorine Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/chlorine
	name = "\improper Canister \[Cl\]"
	icon_state = "black"
	canister_color = "black"
	can_label = 0

/obj/machinery/portable_atmospherics/canister/chlorine/init_air_content()
	..()
	air_contents.adjust_gas(GAS_CHLORINE, MolesForPressure())
	queue_icon_update()

//--------------------------------------------------------
// Empty Canister
//--------------------------------------------------------
/obj/machinery/portable_atmospherics/canister/empty
	start_pressure = 0
	can_label = 1
	canister_type = /obj/machinery/portable_atmospherics/canister

/obj/machinery/portable_atmospherics/canister/empty/New()
	..()
	name = 	initial(canister_type.name)
	icon_state = 	initial(canister_type.icon_state)
	canister_color = 	initial(canister_type.canister_color)

/obj/machinery/portable_atmospherics/canister/empty/Initialize()
	. = ..()
	if(!map_storage_loaded)
		name = 	initial(canister_type.name)
		icon_state = initial(canister_type.icon_state)
		canister_color = initial(canister_type.canister_color)

/obj/machinery/portable_atmospherics/canister/empty/air
	icon_state = "grey"
	canister_type = /obj/machinery/portable_atmospherics/canister/air
/obj/machinery/portable_atmospherics/canister/empty/oxygen
	icon_state = "blue"
	canister_type = /obj/machinery/portable_atmospherics/canister/oxygen
/obj/machinery/portable_atmospherics/canister/empty/phoron
	icon_state = "orange"
	canister_type = /obj/machinery/portable_atmospherics/canister/phoron
/obj/machinery/portable_atmospherics/canister/empty/nitrogen
	icon_state = "red"
	canister_type = /obj/machinery/portable_atmospherics/canister/nitrogen
/obj/machinery/portable_atmospherics/canister/empty/carbon_dioxide
	icon_state = "black"
	canister_type = /obj/machinery/portable_atmospherics/canister/carbon_dioxide
/obj/machinery/portable_atmospherics/canister/empty/sleeping_agent
	icon_state = "redws"
	canister_type = /obj/machinery/portable_atmospherics/canister/sleeping_agent
/obj/machinery/portable_atmospherics/canister/empty/hydrogen
	icon_state = "purple"
	canister_type = /obj/machinery/portable_atmospherics/canister/hydrogen
