/obj/item/map_storage_debugger
	name = "DEBUG ITEM"
	desc = "DEBUG ITEM"
	icon = 'icons/obj/device.dmi'
	icon_state = "eftpos"
	var/list/spawned = list()

/obj/item/map_storage_debugger/proc/spawn_debug(var/mob/user, var/type_path)
	if(!type_path)
		type_path = input(user, "Enter the typepath you want spawned", "debugger","") as text|null
	var/datum/D = new type_path()
	if(D)
		spawned |= D
		return D
	else if(user)
		to_chat(user, "No datum of type [type_path]")

/obj/item/map_storage_debugger/attack_self(mob/user)
	return spawn_debug(user)