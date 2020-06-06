/obj/item/stack/animalhide
	icon = 'icons/obj/items.dmi'
/obj/item/stack/hairlesshide
	icon = 'icons/obj/items.dmi'

/obj/item/stack/animalhide/bear
	name = "bear skin"
	desc = "The by-product of bear farming."
	singular_name = "bear skin piece"
	icon = 'icons/obj/items.dmi'
	icon_state = "sheet-hide"
	color = COLOR_GRAY40

#define MAX_LEATHER_WETNESS 30
/obj/item/stack/wetleather
	icon = 'icons/obj/items.dmi'
	temperature_coefficient = 0.5 //Something like that
	wetness = MAX_LEATHER_WETNESS //Reduced when exposed to high temperautres
	drying_threshold_temperature = 100 CELSIUS //Reduced from 500 kelvin, because currently its hard to make a fire
	var/tmp/time_last_dry = 0 //Keep track of the last time we reduced wetness, so we don't dry too fast
	var/drying_factor = 2.0 //Drying rate is multiplied to this number, to make drying faster or slower

/obj/item/stack/wetleather/New(loc, amount)
	. = ..()
	ADD_SAVED_VAR(wetness)

/obj/item/stack/wetleather/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/stack/wetleather/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/stack/wetleather/Process()
	if (world.time > (time_last_dry + 1.5 SECONDS))
		if(wetness > 0)
			var/drying_this_tick = ((max(temperature, T0C) * 100) / drying_threshold_temperature) * drying_factor //Lets just use a simple linear percentage..
			wetness = max(0, wetness - drying_this_tick)
		else if(wetness <= 0)
			dry_one_sheet()
		time_last_dry = world.time
	return amount > 0? 0 : PROCESS_KILL //We don't need to process anymore when we're empty

/obj/item/stack/wetleather/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature >= drying_threshold_temperature)
		wetness--
		if(wetness == 0)
			dry_one_sheet()

/obj/item/stack/wetleather/proc/dry_one_sheet()
	var/material/M = SSmaterials.get_material_by_name(MATERIAL_LEATHER_GENERIC)
	if(!istype(M))
		log_error("[src]\ref[src] ([x], [y], [z]) couldn't get leather material!!!")
		return FALSE
	M.place_sheet(get_turf(src))
	
	//If there's another sheet of wetleather restart at full wetness for the next one!
	wetness = MAX_LEATHER_WETNESS
	use(1)
	return TRUE

#undef MAX_LEATHER_WETNESS