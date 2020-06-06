/obj/machinery/door/airlock
	var/list/req_access_personal_list = list()

/obj/machinery/door/airlock/New(var/newloc, var/obj/structure/door_assembly/assembly=null)
	..()
	//Do business crap
	if(istype(electronics, /obj/item/weapon/airlock_electronics/personal_electronics))
		var/obj/item/weapon/airlock_electronics/personal_electronics/pe = electronics
		req_access_personal_list = pe.registered_names


/obj/machinery/door/airlock/personal
	door_color = COLOR_WHITE
	name = "Personal Airlock"
	desc = "A door with a personal access lock for an individual(s)."
	assembly_type = /obj/structure/door_assembly/door_assembly_personal

/obj/machinery/door/airlock/personal/attackby(var/obj/item/C, var/mob/user)
	if(istype(C, /obj/item/weapon/card/id/))
		var/obj/item/weapon/card/id/ID = C
		if(req_access_personal_list.len && ID.registered_name == req_access_personal_list[1])
			if(locked)
				unlock()
			else
				lock()
			to_chat(user, SPAN_NOTICE("You [locked ? "lock" : "unlock"]  \the [src]."))
	return ..()
