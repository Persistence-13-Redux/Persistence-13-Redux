/obj/machinery
	//Damage handling
	//maxhealth = 100


/obj/machinery/proc/ispowered()
	return !(stat & NOPOWER)

/obj/machinery/proc/isemped()
	return (stat & EMPED)

// /obj/machinery/after_load()
// 	..()
// 	update_health()

//----------------------------------
// Damage procs
//----------------------------------
// /obj/machinery/update_health(var/damagetype)
// 	..()
// 	//Determine if we're broken or not
// 	if(health <= broken_health)
// 		broken(damagetype)

// //Called when the machine is broken
// /obj/machinery/proc/broken(var/damagetype)
// 	set_broken(TRUE)
// 	update_icon()

/obj/machinery/set_anchored(var/new_anchored)
	. = ..()
	power_change()

