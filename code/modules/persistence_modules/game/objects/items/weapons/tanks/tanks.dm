/obj/item/weapon/tank/New()
	. = ..()
	ADD_SAVED_VAR(air_contents)
	ADD_SAVED_VAR(distribute_pressure)
	ADD_SAVED_VAR(valve_welded)
	ADD_SAVED_VAR(proxyassembly)
	ADD_SAVED_VAR(leaking)
	ADD_SAVED_VAR(wired)

/obj/item/weapon/tank/Initialize()
	var/old_assembly = proxyassembly
	var/old_air = air_contents
	. = ..()
	//Restore the things the base proc will mess with
	if(map_storage_loaded)
		proxyassembly = old_assembly
		proxyassembly.tank = src

		air_contents = old_air
		air_contents.update_values()

/obj/item/device/tankassemblyproxy/New()
	. = ..()
	ADD_SAVED_VAR(tank)
	ADD_SAVED_VAR(assembly)

/obj/item/device/tankassemblyproxy/on_update_icon()
	if(tank)
		tank.update_icon()
	