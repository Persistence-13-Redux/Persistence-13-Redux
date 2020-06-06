/obj/item/weapon/stock_parts/computer/battery_module/New()
	..()
	ADD_SAVED_VAR(battery)

//Prevent base class from overwriting our loaded state
/obj/item/weapon/stock_parts/computer/battery_module/Initialize()
	var/old_battery = battery
	. = ..()
	if(map_storage_loaded)
		battery = old_battery