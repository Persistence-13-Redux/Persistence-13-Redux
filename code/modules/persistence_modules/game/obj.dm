/obj/proc/default_wrench_floor_bolts(var/mob/user, var/obj/item/O, var/delay = 2 SECONDS)
	if(isWrench(O) && (obj_flags & OBJ_FLAG_ANCHORABLE))
		wrench_floor_bolts(user, delay)
		return TRUE
	return FALSE
